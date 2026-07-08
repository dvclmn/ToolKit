//
//  RGBColour.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import CoreTools
import Foundation

/// A lightweight, serialisable RGBA colour model with no direct dependency on SwiftUI or AppKit.
///
/// `RGBColour` stores components as normalised `Double` values in the range
/// `0...1`. It is the main value type to use when shared model code needs to
/// describe a concrete colour without carrying a UI framework colour type
/// through the API.
public struct RGBColour: Identifiable, Equatable, Hashable, Sendable, Codable,
  ColourModel, RGBColourSpaceRepresentable
{
  public let id: UUID
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double

//  public var name: String?

  /// Records whether the colour was initialised from 8-bit channel values.
  public let is255: Bool

  /// Creates a colour from normalised component values.
  ///
  /// `red`, `green`, `blue`, and `alpha` are normalised `0...1` values.
  /// Values outside that range are clamped. Use ``from255(_:_:_:name:)`` for
  /// 8-bit channel values rather than passing `0...255` values here.
//  public init(
//    red: Double,
//    green: Double,
//    blue: Double,
//    is255: Bool = false,
//    alpha: Double = 1.0,
//    name: String? = nil
//  ) {
//    self.init(
//      id: UUID(),
//      red: red,
//      green: green,
//      blue: blue,
//      is255: is255,
//      alpha: alpha,
//      name: name
//    )
//  }
  
  public init(
    id: UUID = UUID(),
//    name: String? = nil,
    red: Double,
    green: Double,
    blue: Double,
    alpha: Double,
    is255: Bool = false,
  ) {
    self.id = id
//    self.name = name
    self.red = ColourComponentNormalisation.clampUnit(red)
    self.green = ColourComponentNormalisation.clampUnit(green)
    self.blue = ColourComponentNormalisation.clampUnit(blue)
    self.alpha = ColourComponentNormalisation.clampUnit(alpha)
    self.is255 = is255
  }


}
// MARK: - Initialisers

extension RGBColour: _ExpressibleByColorLiteral {
  public init(
    _colorLiteralRed red: Float,
    green: Float,
    blue: Float,
    alpha: Float
  ) {
    self.init(
//      name: nil,
      red: Double(red),
      green: Double(green),
      blue: Double(blue),
      alpha: Double(alpha),
    )
  }

}

extension RGBColour {
 
  public init(
    r: Double,
    g: Double,
    b: Double,
    a: Double = 1.0,
    name: String? = nil,
  ) {
    self.init(red: r, green: g, blue: b, alpha: a, name: name)
  }

  public init(
    _ r: Double,
    _ g: Double,
    _ b: Double,
    a: Double = 1.0,
    name: String? = nil
  ) {
    self.init(red: r, green: g, blue: b, alpha: a, name: name)
  }

}

extension RGBColour {

  /// Returns a copy whose colour and alpha components are clamped to `0...1`.
  public var normalised: Self {
    Self(
      id: id,
      red: red,
      green: green,
      blue: blue,
      is255: is255,
      alpha: alpha,
      name: name
    )
  }

  /// Clamps this colour's components to the normalised `0...1` range.
  public mutating func normalise() {
    self = normalised
  }

  public var toOpaque: Self {
    RGBColour(red, green, blue, a: 1.0, name: name)
  }

  public var areAllComponentsNormalised: Bool {
    red.isWithin(.unitRange)
      && green.isWithin(.unitRange)
      && blue.isWithin(.unitRange)
      && alpha.isWithin(.unitRange)
  }

  /// Creates a colour from 8-bit channel values and stores them as normalised components.
  ///
  /// Values outside `0...255` are clamped before normalisation.
  public static func from255(
    _ r: Int,
    _ g: Int,
    _ b: Int,
    name: String? = nil
  ) -> RGBColour {
    self.init(
      red: ColourComponentNormalisation.normalise8Bit(r),
      green: ColourComponentNormalisation.normalise8Bit(g),
      blue: ColourComponentNormalisation.normalise8Bit(b),
      is255: true,
      alpha: 1.0,
      name: name
    )
  }

  /// Creates a grey colour with the specified brightness.
  public static func gray(
    _ brightness: Double,
    alpha: Double = 1.0,
  ) -> RGBColour {
    return RGBColour(
      red: brightness,
      green: brightness,
      blue: brightness,
      alpha: alpha,
      name: "Gray"
    )
  }

}

extension RGBColour: RGBAConvertible {}

extension RGBColour {
  private enum CodingKeys: String, CodingKey {
    case red
    case green
    case blue
    case alpha
    case name
    case is255
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try self.init(
      red: container.decode(Double.self, forKey: .red),
      green: container.decode(Double.self, forKey: .green),
      blue: container.decode(Double.self, forKey: .blue),
      is255: container.decodeIfPresent(Bool.self, forKey: .is255) ?? false,
      alpha: container.decodeIfPresent(Double.self, forKey: .alpha) ?? 1.0,
      name: container.decodeIfPresent(String.self, forKey: .name)
    )
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    let colour = normalised
    try container.encode(colour.red, forKey: .red)
    try container.encode(colour.green, forKey: .green)
    try container.encode(colour.blue, forKey: .blue)
    try container.encode(colour.alpha, forKey: .alpha)
    try container.encodeIfPresent(colour.name, forKey: .name)
    try container.encode(colour.is255, forKey: .is255)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    let lhs = lhs.normalised
    let rhs = rhs.normalised
    return lhs.red == rhs.red
      && lhs.green == rhs.green
      && lhs.blue == rhs.blue
      && lhs.alpha == rhs.alpha
  }

  public func hash(into hasher: inout Hasher) {
    let colour = normalised
    hasher.combine(colour.red)
    hasher.combine(colour.green)
    hasher.combine(colour.blue)
    hasher.combine(colour.alpha)
  }
}

extension RGBColour: CustomStringConvertible {
  public var description: String {
    guard let name else {
      return """
        R: \(red), G: \(green), B: \(blue)
        """
    }
    return """
      RGBColour: \(name)
      """
  }
}
