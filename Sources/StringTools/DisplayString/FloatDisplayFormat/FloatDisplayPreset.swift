//
//  DisplayStringPresets.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/2/2026.
//

import Foundation

/// Preset floating-point display formats.
public enum FloatDisplayPreset: String, CaseIterable, Sendable {
  /// Two decimal places with automatic grouping.
  case standard
  
  /// No decimal places.
  case concise
  
  /// No decimal places.
  case wholeNumber
  
  /// Always reserve sign space, replacing visible plus signs with a space.
  case showSign

  /// The concrete format for the preset.
  public var format: FloatDisplayFormat {
    switch self {
      case .standard: .init()
      case .concise: .init(decimalPlaces: 0)
      case .wholeNumber: .init(decimalPlaces: 0)
      case .showSign: .init(sign: .always(renderPlusSign: false))
    }
  }
}
