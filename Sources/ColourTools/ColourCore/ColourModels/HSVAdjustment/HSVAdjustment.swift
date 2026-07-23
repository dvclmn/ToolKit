//
//  Model+HSVAdjustment.swift
//  ToolKit
//
//  Created by Dave Coleman on 29/6/2025.
//

import Foundation

/// Represents a delta adjustment in HSV space.
///
/// The optional channel values are *relative* changes: applying an adjustment
/// adds each specified value to an existing ``HSVColour``. A `nil` channel has
/// no contribution; `0` is an explicitly neutral contribution. The adjustment
/// itself is not normalised: hue deltas are stored in turns (`1` is one full
/// rotation) and may be negative or exceed one rotation. Saturation and
/// brightness deltas are ordinarily in `-1...1`, but are also left unbounded
/// until application.
///
/// ``HSVColour/applying(_:)`` performs the addition and normalises the
/// resulting absolute colour by wrapping hue and clamping saturation and
/// brightness.
public struct HSVAdjustment: Sendable, Codable, Equatable, Hashable {

  /// A hue delta in turns, where `1` is 360 degrees.
  public var hue: Double?

  /// A saturation delta, conventionally in `-1...1`.
  public var saturation: Double?

  /// A brightness delta, conventionally in `-1...1`.
  public var brightness: Double?

  public init(
    hue: Double? = nil,
    saturation: Double? = nil,
    brightness: Double? = nil,
  ) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
  }

  public init(
    h: Double? = nil,
    s: Double? = nil,
    v: Double? = nil,
  ) {
    self.init(hue: h, saturation: s, brightness: v)
  }

  /// Creates an adjustment from degree-based hue deltas.
  ///
  /// Use this when design values are expressed as angles. For example, `-18`
  /// degrees is stored as `-18 / 360` turns.
  public init(
    hueDegrees: Double? = nil,
    saturation: Double? = nil,
    brightness: Double? = nil,
  ) {
    self.init(
      hue: hueDegrees.map { $0 / 360.0 },
      saturation: saturation,
      brightness: brightness,
    )
  }
}

extension HSVAdjustment {
  public static func adjustments(
    from modifiers: [any HSVModifier]
  ) -> [Self] {
    /// Extracts just the adjustments from the provided modifiers
    return modifiers.map(\.adjustment)
  }

  public static var noAdjustment: HSVAdjustment { .init(h: nil, s: nil, v: nil) }

  public func interpolated(
    towards other: HSVAdjustment,
    amount: Double,
  ) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.interpolated(towards: other.hue, amount: amount),
      saturation: saturation.interpolated(towards: other.saturation, amount: amount),
      brightness: brightness.interpolated(towards: other.brightness, amount: amount),
    )
  }

  public func scaled(by factor: Double) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.map { $0 * factor },
      saturation: saturation.map { $0 * factor },
      brightness: brightness.map { $0 * factor },
    )
  }

  static func applyingModifiers(
    for luminanceColour: any LuminanceReadable,
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose = .legibility,
    chroma: ColourChroma = .standard,
  ) -> Self {

    /// Gather modifier deltas first, then apply the higher-level strength once
    /// while composing their combined adjustment.
    let lumThreshold: LuminanceThreshold = .init(from: luminanceColour)

    let contributors: [any HSVModifier] = [
      lumThreshold,
      purpose,
      chroma,
    ]
    let adjustments = adjustments(from: contributors)

    let combined = adjustments.combined(with: strength.adjustmentStrength)

    return combined
  }

  public func adding(
    other: Self
  ) -> Self {
    HSVAdjustment(
      hue: hue.combined(with: other.hue, using: +),
      saturation: saturation.combined(with: other.saturation, using: +),
      brightness: brightness.combined(with: other.brightness, using: +),
    )
  }
}

public func + (lhs: HSVAdjustment, rhs: HSVAdjustment) -> HSVAdjustment {
  lhs.adding(other: rhs)
}
