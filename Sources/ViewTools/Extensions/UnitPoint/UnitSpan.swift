//
//  UnitSpan.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/10/2025.
//

import SwiftUI

/// Pair of two positions in unit space.
/// Describes a start and end point
public struct UnitSpan: Hashable, Sendable {
  public var start: UnitPoint
  public var end: UnitPoint

  public init(start: UnitPoint, end: UnitPoint) {
    self.start = start
    self.end = end
  }
}

extension UnitSpan {
  public var vector: CGVector {
    CGVector(dx: end.x - start.x, dy: end.y - start.y)
  }
}
