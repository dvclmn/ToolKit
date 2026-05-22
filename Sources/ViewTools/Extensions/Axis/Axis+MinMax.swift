//
//  Axis+MinMax.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/5/2026.
//

import SwiftUI
import CoreTools

extension Axis {
  public func getMinMax(
    _ axis: Axis.MinMax,
    mapping: AxisMapping = .default,
  ) -> Axis {
    switch mapping {
      case .identity:
        switch axis {
          case .minWidth, .maxWidth: .horizontal
          case .minHeight, .maxHeight: .vertical
        }
      case .transposed:
        switch axis {
          case .minWidth, .maxWidth: .vertical
          case .minHeight, .maxHeight: .horizontal
        }
    }
  }
}

extension Axis {
  public enum MinMax {
    case minWidth
    case maxWidth
    case minHeight
    case maxHeight
  }
}
