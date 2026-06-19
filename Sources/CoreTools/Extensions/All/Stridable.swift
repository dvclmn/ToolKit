//
//  Stridable.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/1/2026.
//

import Foundation

// MARK: - Stridable Stepping Extension

extension Strideable {

  /// Advances this value by `step`, clamping the result to `range`.
  ///
  /// - Parameters:
  ///   - step: The amount to step by. Positive and negative values are both supported.
  ///   - range: The closed range to clamp the result within.
  ///   - onEditingChanged: A callback triggered only when the clamped result differs from `self`.
  /// - Returns: The stepped value, clamped to `range`.
  public func stepping(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil,
  ) -> Self {
    let oldValue = self
    let newValue = self.advanced(by: step)
    let clampedValue = min(max(newValue, range.lowerBound), range.upperBound)

    if oldValue != clampedValue {
      onEditingChanged?(oldValue, clampedValue)
    }

    return clampedValue
  }

  /// Advances this value upward by `step`, clamping the result to `range`.
  ///
  /// - Parameters:
  ///   - step: The positive amount to step by.
  ///   - range: The closed range to clamp the result within.
  ///   - onEditingChanged: A callback triggered only when the clamped result differs from `self`.
  /// - Returns: The stepped value, clamped to `range`.
  public func steppingUp(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil,
  ) -> Self {
    stepping(by: step, in: range, onEditingChanged: onEditingChanged)
  }

  /// Advances this value downward by `step`, clamping the result to `range`.
  ///
  /// - Parameters:
  ///   - step: The positive amount to step down by.
  ///   - range: The closed range to clamp the result within.
  ///   - onEditingChanged: A callback triggered only when the clamped result differs from `self`.
  /// - Returns: The stepped value, clamped to `range`.
  public func steppingDown(
    by step: Stride,
    in range: ClosedRange<Self>,
    onEditingChanged: ((Self, Self) -> Void)? = nil,
  ) -> Self {
    stepping(by: -step, in: range, onEditingChanged: onEditingChanged)
  }

  /// Returns whether advancing by `step` would remain inside `range`.
  ///
  /// - Parameters:
  ///   - step: The step amount to test.
  ///   - range: The closed range to check against.
  /// - Returns: `true` if the advanced value remains inside `range`.
  public func canStep(by step: Stride, in range: ClosedRange<Self>) -> Bool {
    let newValue = self.advanced(by: step)
    return newValue >= range.lowerBound && newValue <= range.upperBound
  }
}
