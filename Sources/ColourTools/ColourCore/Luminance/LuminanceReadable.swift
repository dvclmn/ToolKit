//
//  Luma+Conformances.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/10/2025.
//

/// A colour value that can estimate its perceptual luminance.
public protocol LuminanceReadable {
  func luminance(using method: LuminanceMethod) -> Double
  func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold
}

/// Luminance algorithms used by contrast and legibility helpers.
public enum LuminanceMethod: Sendable, Codable {
  case wcag  // Rec.709 coefficients, linearised sRGB
  case rec601  // Video standard
  case hsp  // Perceived brightness
  case cielab  // CIE L* lightness
}
