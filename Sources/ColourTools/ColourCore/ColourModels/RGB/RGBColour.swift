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
///
/// `RGBColour` intentionally stores only component values and generated list
/// identity. Use ``NamedColour`` or ``ColourDescriptor`` when a colour also
/// needs a human-facing label, palette source, design-token name, or symbolic
/// system-colour role.
public struct RGBColour: Identifiable, Equatable, Hashable, Sendable, Codable,
  ColourModel, RGBColourSpaceRepresentable, RGBAConvertible
{
  public let id: UUID
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double

  /// Records whether the colour was initialised from 8-bit channel values.
  ///
  /// The stored components are always normalised `0...1` values either way.
  public let is255: Bool

  /// Creates a colour from normalised component values.
  ///
  /// `red`, `green`, `blue`, and `alpha` are normalised `0...1` values.
  /// Values outside that range are clamped. Use ``from255(_:_:_:)`` for
  /// 8-bit channel values rather than passing `0...255` values here.
  public init(
    id: UUID = UUID(),
    red: Double,
    green: Double,
    blue: Double,
    alpha: Double = 1.0,
    is255: Bool = false,
  ) {
    self.id = id
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
    alpha: Float,
  ) {
    self.init(
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
  ) {
    self.init(red: r, green: g, blue: b, alpha: a)
  }

  public init(
    _ r: Double,
    _ g: Double,
    _ b: Double,
    a: Double = 1.0,
  ) {
    self.init(red: r, green: g, blue: b, alpha: a)
  }

}

extension RGBColour: CustomStringConvertible {
  public var description: String {
    return "R: \(red), G: \(green), B: \(blue)"
  }
}
