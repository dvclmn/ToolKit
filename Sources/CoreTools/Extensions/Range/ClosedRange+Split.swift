//
//  ClosedRange+Split.swift
//  ToolKit
//
//  Created by Dave Coleman on 19/6/2026.
//

import Foundation

extension ClosedRange where Bound: BinaryFloatingPoint, Bound.Stride: BinaryFloatingPoint {

  /// Returns `count` evenly spaced values from lowerBound to upperBound, inclusive.
  ///
  /// Usage:
  /// ```
  /// let values = (0.0...1.0).split(into: 5)
  /// // [0.0, 0.25, 0.5, 0.75, 1.0]
  /// ```
  public func split(into count: Int) -> [Bound] {
    guard count > 1 else { return [lowerBound] }
    let stepSize = Bound(upperBound - lowerBound) / Bound(count - 1)
    return Array(
      stride(
        from: lowerBound,
        through: upperBound,
        by: Bound.Stride(stepSize),
      )
    )
  }

  /// Returns values starting at lowerBound, incremented by stepSize, up to upperBound.
  public func split(by stepSize: Bound) -> [Bound] {
    Array(
      stride(
        from: lowerBound,
        through: upperBound,
        by: Bound.Stride(stepSize),
      )
    )
  }
}
