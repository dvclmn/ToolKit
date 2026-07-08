//
//  RGBColour+Helpers.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

extension RGBColour {

  /// Returns a copy whose colour and alpha components are clamped to `0...1`.
  public var normalised: Self {
    Self(
      id: id,
      red: red,
      green: green,
      blue: blue,
      alpha: alpha,
      is255: is255,
    )
  }

  /// Clamps this colour's components to the normalised `0...1` range.
  public mutating func normalise() {
    self = normalised
  }

  public var toOpaque: Self {
    RGBColour(red, green, blue, a: 1.0)
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
  ) -> RGBColour {
    self.init(
      red: ColourComponentNormalisation.normalise8Bit(r),
      green: ColourComponentNormalisation.normalise8Bit(g),
      blue: ColourComponentNormalisation.normalise8Bit(b),
      alpha: 1.0,
      is255: true,
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
    )
  }

}
