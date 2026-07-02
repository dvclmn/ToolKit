//
//  Model+LumaThreshold.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/9/2025.
//

import Foundation

public enum LuminanceThreshold: HSVModifier {
  case dark
  case light
  
  public init(
    from colour: any LuminanceReadable,
    using method: LuminanceMethod = .wcag
  ) {
    self = colour.luminance(using: method) > 0.35 ? .light : .dark
  }
  
  /// A basic baseline adjustment based on what suits light vs dark colours
  public var adjustment: HSVAdjustment {
    switch self {
      case .dark: HSVAdjustment(hueDegrees: -18, saturation: -0.01, brightness: 0.75)
      case .light: HSVAdjustment(hueDegrees: -16, saturation: 0.35, brightness: -0.75)
    }
  }
}
