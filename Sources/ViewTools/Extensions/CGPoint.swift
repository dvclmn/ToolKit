//
//  CGPoint.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension CGPoint {
  public func isNearUnitPoint(
    _ unitPoint: UnitPoint,
    in size: CGSize,
    threshold: CGFloat = 10,
  ) -> Bool {
    let targetPoint = unitPoint.toCGPoint(in: size)
    return self.distance(to: targetPoint) <= threshold
  }
  
  public func debugColour(
    unitPoint: UnitPoint,
    in size: CGSize,
  ) -> Color {
    guard self.isNearUnitPoint(unitPoint, in: size) else {
      return Color.clear
    }
    return unitPoint.debugColour
  }
  
  
  /// Returns a new CGPoint aligned relative to a container of the given size,
  /// using a unit point as the anchor.
  ///
  /// Important: For this one, think of `self` as an offset or adjustment to be
  /// applied relative to the anchor point described by the `unitPoint`.
  ///
  /// For example, if you wanted to place something 10pts to the right and 5pts
  /// below the bottomTrailing of a 300×400 container:
  /// ```
  /// let offset = CGPoint(x: 10, y: 5)
  /// let result = offset.aligned(to: .bottomTrailing, in: CGSize(width: 300, height: 400))
  /// // → CGPoint(x: 310, y: 405)
  /// ```
  public func aligned(
    to unitPoint: UnitPoint,
    in containerSize: CGSize,
  ) -> CGPoint {
    let anchor = CGPoint(
      x: unitPoint.x * containerSize.width,
      y: unitPoint.y * containerSize.height,
    )
    return CGPoint(x: anchor.x + self.x, y: anchor.y + self.y)
  }
  
  /// Alternative to above `aligned(to:,in:)`
  /// This is aligning a `CGPoint` within a container, based on anchor.
  /// Aka shifts the current point so that it lands at the target anchor.
  ///
  /// Returns a new point positioned within a container so that this point
  /// becomes aligned to the specified anchor.
  public func repositioned(
    to unitPoint: UnitPoint,
    in containerSize: CGSize,
  ) -> CGPoint {
    let anchor = CGPoint(
      x: unitPoint.x * containerSize.width,
      y: unitPoint.y * containerSize.height, )
    return CGPoint(x: anchor.x - self.x, y: anchor.y - self.y)
  }
  
  /// Returns the closest named UnitPoint (e.g., .topLeading, .center, etc) within a given size.
  /// If the point is within a central region defined by tolerance, `.center` is returned.
  public func nearestAnchor(
    in size: CGSize,
    centerTolerance: CGFloat = 0.2,
  ) -> UnitPoint {
    let relative = toUnitPoint(in: size)
    
    /// If close enough to center, return .center early
    let center = UnitPoint.center
    let dx = abs(relative.x - center.x)
    let dy = abs(relative.y - center.y)
    
    if dx <= centerTolerance / 2 && dy <= centerTolerance / 2 {
      return .center
    }
    
    let anchors: [UnitPoint] = [
      .topLeading, .top, .topTrailing,
      .leading, .trailing,
      .bottomLeading, .bottom, .bottomTrailing,
    ]
    
    return anchors.min(
      by: { relative.distanceSquared(to: $0) < relative.distanceSquared(to: $1) }
    ) ?? .center
  }

}
