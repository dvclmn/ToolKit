//
//  Model+HSV.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import CoreTools
import Foundation

/// Notes:
/// In HSV, brightness (value) is the *maximum* of the RGB channels.
/// But luminance is a weighted sum of the linearised RGB values,
/// which means:
/// -  Two colours with the same HSV value might have
///   wildly different luminance.
/// -  Luminance depends on how the three channels contribute
///   based on human perception.

//
/// A lightweight, serialisable HSV colour model.
///
/// Hue, saturation, brightness, and alpha are represented as normalised
/// `Double` values. Hue uses the wrapped unit interval `[0, 1)`, where `0.5`
/// represents 180 degrees. Saturation, brightness, and alpha are clamped to
/// `0...1`. This type is useful for colour-editing interactions because hue,
/// chroma, and brightness can be adjusted independently before converting back
/// to ``RGBColour``.
public struct HSVColour: Identifiable, Equatable, Sendable, ColourModel, Hashable {
  public let id: UUID
  public var hue: Double
  public var saturation: Double
  public var brightness: Double
  public var alpha: Double
  public var name: String?

  public init(
    hue: Double,
    saturation: Double,
    brightness: Double,
    alpha: Double = 1.0,
    name: String? = nil,
  ) {
    self.init(
      id: UUID(),
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha,
      name: name
    )
  }

  private init(
    id: UUID,
    hue: Double,
    saturation: Double,
    brightness: Double,
    alpha: Double,
    name: String?
  ) {
    self.id = id
    self.hue = ColourComponentNormalisation.wrapHue(hue)
    self.saturation = ColourComponentNormalisation.clampUnit(saturation)
    self.brightness = ColourComponentNormalisation.clampUnit(brightness)
    self.alpha = ColourComponentNormalisation.clampUnit(alpha)
    self.name = name
  }

  public init(
    h: Double,
    s: Double,
    v: Double,
    alpha: Double = 1.0,
    name: String? = nil,
  ) {
    self.init(hue: h, saturation: s, brightness: v, alpha: alpha, name: name)
  }
}

extension HSVColour {

  /// Returns a copy whose hue is wrapped to `[0, 1)` and other components are
  /// clamped to `0...1`.
  public var normalised: Self {
    Self(
      id: id,
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha,
      name: name
    )
  }

  /// Normalises this colour in place.
  public mutating func normalise() {
    self = normalised
  }

  public var areAllComponentsNormalised: Bool {
    hue >= 0 && hue < 1
      && saturation.isWithin(.unitRange)
      && brightness.isWithin(.unitRange)
      && alpha.isWithin(.unitRange)
  }

  /// Hue is only meaningful when there is chroma and not pure black.
  /// (You can decide whether `brightness == 0` should count as undefined even if saturation > 0;
  /// practically it behaves as undefined because it round-trips poorly.)
  public var isHueDefined: Bool {
    /// If you’d rather allow hue when brightness == 0 (mathematically it’s
    /// still not observable), change to saturation > 0.
    saturation > 0 && brightness > 0
  }

  /// Returns `incoming`, but if its hue is undefined (grey/black), preserves `self.hue`.
  public func mergingPreservingHue(_ incoming: HSVColour) -> HSVColour {
    guard incoming.isHueDefined else {
      var result = incoming
      result.hue = self.hue
      return result
    }
    return incoming
  }

  public var hueOnly: Self {
    Self(
      hue: hue,
      saturation: 1.0,
      brightness: 1.0,
      alpha: 1.0,
    )
  }
  public var hueSatOnly: Self {
    Self(
      hue: hue,
      saturation: saturation,
      brightness: 1.0,
      alpha: 1.0,
    )
  }

  public var toOpaque: HSVColour {
    HSVColour(h: hue, s: saturation, v: brightness, alpha: 1.0, name: name)
  }

  /// Convert to RGB and back again while preserving hue across undefined-hue zones.
  /// Useful when RGB is your bound storage but HSV drives interaction.
  public func toRGBPreservingHueRoundTrip(
    from previous: HSVColour?
  ) -> (rgb: RGBColour, hsv: HSVColour) {
    let rgb = self.toRGB
    let hsv = rgb.toHSV(preservingHueFrom: previous)
    return (rgb, hsv)
  }

  public var toRGB: RGBColour { RGBColour(fromHSV: self) }

  public static func gray(
    _ brightness: Double,
    alpha: Double = 1.0,
  ) -> HSVColour {
    return HSVColour(
      hue: 0,
      saturation: 0,
      brightness: brightness,
      alpha: alpha,
      name: "Gray",
    )
  }

  /// This is handled in ``HSVAdjustable/adjust(by:)``
  //  func applying(adjustment: HSVAdjustment) -> HSVColour {
  //    let adjustedHue = adjustment.hue.map { hue + $0 } ?? hue
  //
  //    let adjustedSaturation =
  //      adjustment.saturation.map { saturation + $0 } ?? saturation
  //
  //    let adjustedBrightness =
  //      adjustment.brightness.map { brightness + $0 } ?? brightness
  //
  //    return HSVColour(
  //      hue: adjustedHue,
  //      saturation: adjustedSaturation,
  //      brightness: adjustedBrightness,
  //      alpha: alpha,
  //      name: self.name
  //    )
  //  }
}

//
//public func + (lhs: HSVColour, rhs: HSVAdjustment) -> HSVColour {
//  lhs.applying(adjustment: rhs)
//}

extension HSVColour: CustomStringConvertible {
  public var description: String {
    let result = """
      HSVColour[H: \(hue), S: \(saturation), V: \(brightness), Name: \(name ?? "nil")]
      """

    return result
  }
}

extension HSVColour {
  private enum CodingKeys: String, CodingKey {
    case hue
    case saturation
    case brightness
    case alpha
    case name
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try self.init(
      hue: container.decode(Double.self, forKey: .hue),
      saturation: container.decode(Double.self, forKey: .saturation),
      brightness: container.decode(Double.self, forKey: .brightness),
      alpha: container.decodeIfPresent(Double.self, forKey: .alpha) ?? 1.0,
      name: container.decodeIfPresent(String.self, forKey: .name)
    )
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    let colour = normalised
    try container.encode(colour.hue, forKey: .hue)
    try container.encode(colour.saturation, forKey: .saturation)
    try container.encode(colour.brightness, forKey: .brightness)
    try container.encode(colour.alpha, forKey: .alpha)
    try container.encodeIfPresent(colour.name, forKey: .name)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    let lhs = lhs.normalised
    let rhs = rhs.normalised
    return lhs.hue == rhs.hue
      && lhs.saturation == rhs.saturation
      && lhs.brightness == rhs.brightness
      && lhs.alpha == rhs.alpha
  }

  public func hash(into hasher: inout Hasher) {
    let colour = normalised
    hasher.combine(colour.hue)
    hasher.combine(colour.saturation)
    hasher.combine(colour.brightness)
    hasher.combine(colour.alpha)
  }
}
