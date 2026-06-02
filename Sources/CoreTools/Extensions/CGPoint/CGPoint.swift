//
//  CGPoint.swift
//  Collection
//
//  Created by Dave Coleman on 16/11/2024.
//

import Foundation

extension CGPoint {

  public func distance(to other: CGPoint) -> CGFloat {
    let dx = CGFloat(x - other.x)
    let dy = CGFloat(y - other.y)
    return sqrt((dx * dx) + (dy * dy))
  }

  public init(_ x: CGFloat, _ y: CGFloat) {
    self.init(x: x, y: y)
  }
}

extension CGPoint {

  public func centredIn(size: CGSize) -> CGPoint {
    let centred: CGSize = size / 2
    return self - centred
  }

  func normalise() -> CGPoint {
    let l = length
    return CGPoint(x / l, y / l)
  }

  /// Previously: `sqrt(x * x + y * y)`
  public var length: CGFloat { hypot(x, y) }

  /// Standard Linear Interpolation (Lerp)
  /// Aligns with VectorArithmetic's logic.
  public func lerp(to end: CGPoint, t: CGFloat) -> CGPoint {
    CGPoint(
      x: x + (end.x - x) * t,
      y: y + (end.y - y) * t,
    )
  }

  /// Calculate the scaled movement from a previous point.
  /// Renamed from 'delta' to be more descriptive.
  public func scaledOffset(from lastPosition: CGPoint, sensitivity: CGFloat) -> CGVector {
    CGVector(
      dx: (self.x - lastPosition.x) * sensitivity,
      dy: (self.y - lastPosition.y) * sensitivity,
    )
  }

  public func midpoint(to other: Self) -> Self {
    lerp(to: other, t: 0.5)
  }

  public static func midPoint(
    from p1: CGPoint,
    to p2: CGPoint,
  ) -> CGPoint {
    p1.lerp(to: p2, t: 0.5)
  }
}
