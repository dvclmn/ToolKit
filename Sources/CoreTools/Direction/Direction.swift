//
//  Direction.swift
//  ToolKit
//
//  Created by Dave Coleman on 3/7/2025.
//

import Foundation

/// A cardinal direction in a top-left-origin coordinate system.
public enum Direction: String, CaseIterable, Identifiable {
  case up
  case down
  case left
  case right
}

extension Direction {

  public var id: String { rawValue }

  /// A `+1` or `-1` multiplier for movement along one axis.
  public var scalar: Int {
    switch self {
      case .up, .left: -1
      case .down, .right: 1
    }
  }

  public var isHorizontal: Bool {
    switch self {
      case .left, .right: true
      default: false
    }
  }

  public var isVertical: Bool {
    switch self {
      case .up, .down: true
      default: false
    }
  }

  /// Mutates `value` by moving it along this direction by `delta`.
  public func update<T: BinaryFloatingPoint>(_ value: inout T, by delta: T) {
    value += T(scalar) * delta
  }

  /// Returns `value` moved along this direction by `delta`.
  public func apply(to value: Int, by delta: Int = 1) -> Int {
    value + scalar * delta
  }

  /// Returns `value` moved along this direction by `delta`.
  public func apply<T: BinaryFloatingPoint>(to value: T, by delta: T) -> T {
    value + T(scalar) * delta
  }

  public var toAxis: GeometryAxis {
    isVertical ? .vertical : .horizontal
  }

  /// Returns an integer tuple offset in this direction.
  public func offset(x: Int, y: Int, by delta: Int = 1) -> (x: Int, y: Int) {
    switch toAxis {
      case .vertical:
        return (x, y + scalar * delta)
      case .horizontal:
        return (x + scalar * delta, y)
    }
  }

  /// Returns a floating-point tuple offset in this direction.
  public func offset(
    x: CGFloat,
    y: CGFloat,
    by delta: CGFloat = 1,
  ) -> (x: CGFloat, y: CGFloat) {
    switch toAxis {
      case .vertical:
        return (x, y + CGFloat(scalar) * delta)
      case .horizontal:
        return (x + CGFloat(scalar) * delta, y)
    }
  }

  /// Advance a single coordinate along this direction's axis by `delta`.
  ///
  /// If the direction is vertical, `x` is returned unchanged.
  public func advance(x: Int, by delta: Int = 1) -> Int {
    guard toAxis == .horizontal else { return x }
    return x + scalar * delta
  }

  /// Advances a y-coordinate when this direction is vertical.
  ///
  /// If the direction is horizontal, `y` is returned unchanged.
  public func advance(y: Int, by delta: Int = 1) -> Int {
    guard toAxis == .vertical else { return y }
    return y + scalar * delta
  }

}

extension Direction {
  public var isUp: Bool { self == .up }
  public var isDown: Bool { self == .down }
  public var isLeft: Bool { self == .left }
  public var isRight: Bool { self == .right }
}
