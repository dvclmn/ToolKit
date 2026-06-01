//
//  BinaryFloatingPoint.swift
//  ToolKit
//
//  Created by Dave Coleman on 27/2/2025.
//

import Foundation

/// Returns `2π` as the requested floating-point type.
public func twoPi<T: BinaryFloatingPoint>() -> T { T.pi * 2 }

extension BinaryFloatingPoint {

  /// Returns this value increased by `amount`, optionally clamped to `range`.
  public func incrementing(
    by amount: Self,
    in range: ClosedRange<Self>? = nil,
  ) -> Self {
    var result = self + amount
    if let range {
      result = min(max(result, range.lowerBound), range.upperBound)
    }
    return result
  }

  /// Increases this value by `amount`, optionally clamping the result to `range`.
  public mutating func increment(by amount: Self, in range: ClosedRange<Self>? = nil) {
    self = incrementing(by: amount, in: range)
  }

  /// Decreases this value by `amount`, optionally clamping the result to `range`.
  public mutating func decrement(by amount: Self, in range: ClosedRange<Self>? = nil) {
    self = incrementing(by: -amount, in: range)
  }

  /// Maps a raw distance through an arctangent falloff curve.
  public func scaledDistance(
    radius: Self,
    tension: Self,
  ) -> Self {
    let tensionValue = Double(self / tension)
    let halfPi = Double.pi / 2
    return radius * Self(atan(tensionValue / halfPi))
  }

  /// Returns the complement of this value after clamping it to `0...1`.
  public var inversePercentage: Self {
    // Ensure the input is between 0.0 and 1.0.
    let bounded = min(max(self, 0.0), 1.0)
    return 1.0 - bounded
  }

  /// Wraps a phase angle into the `0..<2π` interval.
  public func wrapPhase(_ phase: CGFloat) -> CGFloat {
    var r = phase.truncatingRemainder(dividingBy: twoPi())
    if r < 0 { r += twoPi() }  // keep in [0, 2π)
    return r
  }

  /// Returns a larger value using the golden ratio as a gentle growth step.
  public var bump: Self {
    let nextFib = self * 1.618
    return (self + nextFib) / 2  // Midpoint between current and next
  }

  /// Returns a smaller value using the inverse golden ratio as a gentle reduction step.
  public var bumpDown: Self {
    let prevFib = self * 0.618
    return (self + prevFib) / 2  // Midpoint between current and previous
  }

  public var halved: Self { self / 2 }
  public var clampedToPositive: Self { clamped(0, .infinity) }
  public var clampedZeroToOne: Self { clamped(0, 1) }

  /// Calculates height from width using the given aspect ratio
  /// - Parameter aspectRatio: The aspect ratio (width / height)
  /// - Returns: The calculated height value
  public func height(for aspectRatio: Self) -> Self {
    return self / aspectRatio
  }

  /// Returns the shortest angular distance between two angles.
  public static func angleDelta(_ angle1: Self, _ angle2: Self) -> Self {
    var delta = angle1 - angle2

    // Normalise to the `-π...π` range.
    while delta > .pi { delta -= 2 * .pi }
    while delta < -.pi { delta += 2 * .pi }

    return abs(delta)
  }

  public static func randomNoise(
    _ phaseAtPosition: CGFloat = 0
  ) -> CGFloat {
    sin(phaseAtPosition * 7.3) * 0.3 + cos(phaseAtPosition * 13.7) * 0.2
  }

}
