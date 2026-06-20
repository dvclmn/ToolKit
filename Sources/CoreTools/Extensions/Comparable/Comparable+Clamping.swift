//
//  Clamping.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/4/2026.
//

import Foundation

extension Comparable {

  /// Returns `self` clamped to the provided range.
  ///
  /// This limits a value to existing bounds; it does not convert the value into
  /// a `0...1` fraction.
  @inline(__always)
  public func clamped(to range: ClosedRange<Self>) -> Self {
    return clamped(range.lowerBound, range.upperBound)
  }

  /// Returns `self` unchanged when `range` is `nil`.
  @inline(__always)
  public func clampedIfNeeded(to range: ClosedRange<Self>?) -> Self {
    guard let range else { return self }
    return clamped(range.lowerBound, range.upperBound)
  }

  /// `min` == `lowerBound`
  /// `max` == `upperBound`
  @inline(__always)
  public func clamped(_ lower: Self, _ upper: Self) -> Self {
    guard lower < upper else { return self }
    return Swift.min(upper, Swift.max(lower, self))
  }
}

extension Comparable where Self: BinaryFloatingPoint {
  public func clamped(toIntRange range: Range<Int>) -> Self {
    return clamped(Self(range.lowerBound), Self(range.upperBound))
  }
}
