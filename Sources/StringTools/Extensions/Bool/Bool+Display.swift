//
//  Bool.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

/// Common textual formats for displaying Boolean values.
public enum BooleanDisplayFormat {

  case standard

  /// `Yes` or `No`.
  case yesNo

  /// `On` or `Off`.
  case onOff

  /// `Enabled` or `Disabled`.
  case enabledDisabled

  /// Checkmark-style SF Symbol text.
  case checkmark

  /// Eye-style SF Symbol text.
  case eye

  /// `Active` or `Inactive`.
  case activeInactive

  /// Caller-supplied text for `true` and `false`.
  case custom(trueText: String, falseText: String)

  /// Formats a Boolean value using this display format.
  public func format(_ value: Bool) -> String {
    switch self {
      case .standard: value ? "true" : "false"
      case .yesNo: value ? "Yes" : "No"
      case .onOff: value ? "On" : "Off"
      case .enabledDisabled: value ? "Enabled" : "Disabled"
      case .checkmark: value ? "􀆅" : "􀆄"
      case .eye: value ? "􀋭" : "􀋯"
      case .activeInactive: value ? "Active" : "Inactive"
      case .custom(let trueText, let falseText): value ? trueText : falseText
    }
  }
}

extension Bool {
  /// Displays the Boolean value using a predefined format.
  public func displayAs(_ format: BooleanDisplayFormat) -> String {
    format.format(self)
  }

  /// Displays the Boolean value using caller-supplied text.
  public func displayAs(trueText: String, falseText: String) -> String {
    BooleanDisplayFormat.custom(trueText: trueText, falseText: falseText).format(self)
  }

}
