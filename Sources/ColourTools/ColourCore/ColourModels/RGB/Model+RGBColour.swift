//
//  Model+RGB.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

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

  public var name: String?

  /// Records whether the colour was initialised from 8-bit channel values.
  public let is255: Bool

  /// Creates a colour from normalised component values.
  ///
  /// `red`, `green`, `blue`, and `alpha` are expected to be in `0...1`.
  /// The initializer does not currently clamp or validate those values, because
  /// existing callers may rely on inspecting or correcting out-of-range values
  /// themselves.
  // TODO: Add check for 0-255 vs normalised [0-1] values
  public init(
    red: Double,
    green: Double,
    blue: Double,
    is255: Bool = false,
    alpha: Double = 1.0,
    name: String? = nil
  ) {
    self.id = UUID()
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
    self.name = name
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
      red: Double(red),
      green: Double(green),
      blue: Double(blue),
      alpha: Double(alpha),
      name: nil
    )
  }

}

extension RGBColour {
  // To suit colour literals
  // #colorLiteral(red: 1, green: 0.5273173451, blue: 1, alpha: 1)
  //  public init?(
  //    _ cgColor: CGColor,
  //  ) {
  //    /// Try to ensure we are working in an RGB-compatible color space
  //    let rgbColor: CGColor
  //    if let cs = cgColor.colorSpace, cs.model == .rgb {
  //      rgbColor = cgColor
  //    } else if let converted = cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil) {
  //      rgbColor = converted
  //    } else {
  //      /// As a last resort, try to read components anyway (may be grayscale, etc.)
  //      rgbColor = cgColor
  //    }
  //
  //    guard let components = rgbColor.components else { return nil }
  //
  //    let model = rgbColor.colorSpace?.model
  //
  //    let rCGFloat: CGFloat
  //    let gCGFloat: CGFloat
  //    let bCGFloat: CGFloat
  //    let aCGFloat: CGFloat
  //
  //    switch model {
  //    case .some(.rgb):
  //      // Expect 3 (RGB) or 4 (RGBA) components
  //      guard components.count >= 3 else { return nil }
  //      rCGFloat = components[0]
  //      gCGFloat = components[1]
  //      bCGFloat = components[2]
  //      aCGFloat = components.count >= 4 ? components[3] : rgbColor.alpha
  //
  //    case .some(.monochrome):
  //      /// Grayscale color spaces provide one component (white), plus optional alpha
  //      guard let white = components.first else { return nil }
  //      rCGFloat = white
  //      gCGFloat = white
  //      bCGFloat = white
  //      aCGFloat = components.count >= 2 ? components[1] : rgbColor.alpha
  //
  //    default:
  //      /// Unsupported color model for our simple RGB extraction
  //      return nil
  //    }
  //
  //    self.init(
  //      red: Double(rCGFloat),
  //      green: Double(gCGFloat),
  //      blue: Double(bCGFloat),
  //      alpha: Double(aCGFloat),
  //      name: nil
  //    )
  //  }

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

  public var toOpaque: Self {
    RGBColour(red, green, blue, a: 1.0, name: name)
  }

  public var areAllComponentsNormalised: Bool {
    red.isWithin(.unitRange)
      && green.isWithin(.unitRange)
      && blue.isWithin(.unitRange)
  }

  /// Creates a colour from 8-bit channel values and stores them as normalised components.
  public static func from255(
    _ r: Int,
    _ g: Int,
    _ b: Int,
    name: String? = nil
  ) -> RGBColour {
    self.init(
      red: Double(r) / 255.0,
      green: Double(g) / 255.0,
      blue: Double(b) / 255.0,
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
