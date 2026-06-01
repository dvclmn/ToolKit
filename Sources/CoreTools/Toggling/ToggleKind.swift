//
//  ToggleKind.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

/// The semantic kind of boolean value represented by a ``ToggleKey``.
public enum ToggleKind: String, Sendable {
  case expanded
  case enabled
}

extension ToggleKind {
  /// Suffix used when building camel-case storage keys.
  package var camelSuffix: String {
    switch self {
      case .enabled: return "Enabled"
      case .expanded: return "Expanded"
    }
  }
}
