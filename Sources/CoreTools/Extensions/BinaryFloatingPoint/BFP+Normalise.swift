//
//  BFP+Normalise.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/8/2025.
//

import Foundation

extension BinaryFloatingPoint {

  /// Normalises this value into `0...1`, returning `0` if `range` is invalid.
  public func normalised(in range: ClosedRange<Self>) -> Self {
    normalisedIfValid(in: range) ?? 0
  }

  /// Normalises this value from `range` into `0...1`.
  ///
  /// Values outside `range` are clamped before conversion. Returns `nil` when
  /// the range has no positive width.
  public func normalisedIfValid(in range: ClosedRange<Self>) -> Self? {
    guard range.isGreaterThanZero else { return nil }
    let clamped = clamped(to: range)
    return (clamped - range.lowerBound) / (range.upperBound - range.lowerBound)
  }

  /// Denormalises this value from `0...1` into `range`, returning `0` if `range` is invalid.
  public func denormalised(in range: ClosedRange<Self>) -> Self {
    denormalisedIfValid(in: range) ?? 0
  }

  /// Denormalises this value from `0...1` into `range`.
  ///
  /// Values outside `0...1` extend beyond `range` proportionally. Returns `nil`
  /// when the range has no positive width.
  public func denormalisedIfValid(in range: ClosedRange<Self>) -> Self? {
    guard range.isGreaterThanZero else { return nil }
    return range.lowerBound + self * (range.upperBound - range.lowerBound)
  }

}
