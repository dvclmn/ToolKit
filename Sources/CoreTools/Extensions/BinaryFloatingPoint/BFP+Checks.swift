//
//  BinaryFloatingPoint.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/4/2026.
//

import Foundation

extension BinaryFloatingPoint {
  
  /// A Boolean value indicating whether this value is finite and not NaN.
  public var isValid: Bool {
    return self.isFinite && !self.isNaN
  }
  
  /// Returns `true` if this value falls within the specified closed range (inclusive of bounds).
  /// - Parameter range: The closed range to check against
  /// - Returns: `true` if the value is within the range, `false` otherwise
  public func isWithin(_ range: ClosedRange<Self>) -> Bool {
    return range.contains(self)
  }
  
  /// Returns `true` if this value falls within the specified bounds (inclusive).
  /// - Parameters:
  ///   - lowerBound: The lower bound (inclusive)
  ///   - upperBound: The upper bound (inclusive)
  /// - Returns: `true` if the value is within the bounds, `false` otherwise
  public func isWithin(_ lowerBound: Self, _ upperBound: Self) -> Bool {
    return self >= lowerBound && self <= upperBound
  }
  
  /// Returns this value as a percentage of its position within `range`.
  public func toPercent(within range: ClosedRange<Self>) -> Self {
    self.normalised(in: range) * 100
  }
  
  public func isApproximatelyEqual(
    to other: Self,
    within tolerance: Self = .ulpOfOne
  ) -> Bool {
    abs(self - other) <= tolerance
  }
  
  public var isGreaterThanZero: Bool { self > 0 }
  public var isFiniteAndGreaterThanZero: Bool { isFinite && self > 0 }
  public var isGreaterThanOrEqualToZero: Bool { self >= 0 }
  
}
