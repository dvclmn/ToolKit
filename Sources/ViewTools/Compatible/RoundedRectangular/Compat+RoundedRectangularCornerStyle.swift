//
//  Compat+RoundedRectangularCornerStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

public enum RoundedRectangularCornerStyleCompatible: Sendable, Hashable {
  case fixed(CGFloat)
  indirect case concentric(minimum: RoundedRectangularCornerStyleCompatible? = nil)
}

extension RoundedRectangularCornerStyleCompatible {
  func inset(by amount: CGFloat) -> Self {
    switch self {
      case .fixed(let radius):
        .fixed(max(radius - amount, 0))
      case .concentric(let minimum):
        .concentric(minimum: minimum?.inset(by: amount))
    }
  }
}
