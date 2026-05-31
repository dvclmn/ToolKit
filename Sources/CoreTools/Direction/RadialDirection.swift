//
//  RadialDirection.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

/// In some cases (like for `UnitPoint`) directionality can be inferred
public enum RadialDirection: Sendable {
  case outward
  case inward
}

extension RadialDirection {
  /// Returns +1 for outward, -1 for inward
  public var multiplier: CGFloat {
    switch self {
      case .outward: +1
      case .inward: -1
    }
  }
}

