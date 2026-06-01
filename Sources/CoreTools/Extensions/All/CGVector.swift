//
//  CGVector.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/5/2025.
//

import Foundation

extension CGVector {

  /// Returns a vector with magnitude no greater than `maxVelocity`.
  ///
  /// Direction is preserved when the vector needs to be scaled down.
  public func clampVelocity(
    maxVelocity: Double = 10.0
  ) -> CGVector {

    guard magnitude > maxVelocity else { return self }

    // Scale down to max velocity while preserving direction
    let scale = maxVelocity / magnitude

    return CGVector(
      dx: self.dx * scale,
      dy: self.dy * scale,
    )
  }

  /// Creates a velocity vector from `from` to `to` over `dt` seconds.
  public static func between(
    _ from: CGPoint,
    _ to: CGPoint,
    dt: TimeInterval,
  ) -> CGVector {
    guard dt > 0 else { return .zero }
    return CGVector(
      dx: (to.x - from.x) / dt,
      dy: (to.y - from.y) / dt,
    )
  }

  /// The scalar magnitude of the velocity vector.
  public var speed: CGFloat {
    return sqrt(dx * dx + dy * dy)
  }

  public var magnitude: CGFloat { speed }

  /// Returns `speed` as a `0...1` fraction of `maxSpeed`.
  public func normalisedSpeed(
    maxSpeed: CGFloat = 1000.0
  ) -> CGFloat {
    return min(speed / maxSpeed, 1.0)
  }
}
