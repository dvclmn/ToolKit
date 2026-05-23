//
//  Luma+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

public protocol LuminanceReadable {
  func luminance(using method: LuminanceMethod) -> Double
  func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold
}

public enum LuminanceMethod: Sendable, Codable {
  case wcag  // Rec.709 coefficients, linearised sRGB
  case rec601  // Video standard
  case hsp  // Perceived brightness
  case cielab  // CIE L* lightness
}
