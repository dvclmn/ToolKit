//
//  SignDisplay.swift
//  ToolKit
//
//  Created by Dave Coleman on 14/2/2026.
//

import Foundation

/// Controls how signs are displayed for formatted floating-point values.
public enum SignDisplay: Sendable, Equatable {
  /// Displays a minus sign for negative values.
  case standard

  /// Reserves sign space for positive and negative values, optionally rendering
  /// the `+` character.
  case always(renderPlusSign: Bool = false)

  /// Suppresses signs, including minus signs.
  case none

  // MARK: - Formatting helpers

  package func processingLeadingPlus(in value: String) -> String {
    // Only act on an explicit leading plus sign.
    guard let first = value.first, first == "+" else { return value }
    switch self {
      case .always(let renderPlusSign):
        guard renderPlusSign else {
          // Replace only the first leading plus with a space.
          var result = value
          let startIndex = result.startIndex
          result.replaceSubrange(startIndex...startIndex, with: " ")
          return result
        }
        return value
      case .standard, .none:
        // These modes do not force a plus sign.
        return value
    }
  }

  package var shouldPostProcess: Bool {
    switch self {
      case .standard, .none: false
      case .always: true
    }
  }

  package var toNativeStrategy: FloatingPointFormatStyle<Double>.Configuration.SignDisplayStrategy {
    switch self {
      case .standard: .automatic
      case .always: .always(includingZero: true)
      case .none: .never
    }
  }
}
