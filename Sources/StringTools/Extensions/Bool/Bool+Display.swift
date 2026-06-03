//
//  Bool.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

/// Common textual formats for displaying Boolean values.
public enum BooleanDisplayFormat {
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
      case .yesNo:
        return value ? "Yes" : "No"
        
      case .onOff:
        return value ? "On" : "Off"
        
      case .enabledDisabled:
        return value ? "Enabled" : "Disabled"
        
      case .checkmark:
        return value ? "􀆅" : "􀆄"
        
      case .eye:
        return value ? "􀋭" : "􀋯"
        
      case .activeInactive:
        return value ? "Active" : "Inactive"
        
      case .custom(let trueText, let falseText):
        return value ? trueText : falseText
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
