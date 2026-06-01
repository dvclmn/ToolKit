//
//  RadialDirection.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/1/2026.
//

import Foundation

/// Direction of movement relative to a centre point.
public enum RadialDirection: Sendable {
  case outward
  case inward
}

extension RadialDirection {
  /// Returns `+1` for outward movement and `-1` for inward movement.
  public var multiplier: CGFloat {
    switch self {
      case .outward: +1
      case .inward: -1
    }
  }
}
