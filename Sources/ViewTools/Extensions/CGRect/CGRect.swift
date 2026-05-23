//
//  CGRect.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension CGRect {
  public var path: Path { Path(self) }

  public func edgePoints(for edge: Edge) -> (start: CGPoint, end: CGPoint) {
    switch edge {
      case .top: (CGPoint(x: minX, y: minY), CGPoint(x: maxX, y: minY))
      case .bottom: (CGPoint(x: minX, y: maxY), CGPoint(x: maxX, y: maxY))
      case .leading: (CGPoint(x: minX, y: minY), CGPoint(x: minX, y: maxY))
      case .trailing: (CGPoint(x: maxX, y: minY), CGPoint(x: maxX, y: maxY))
    }
  }
  
  
  /// Produces a CGRect positioned inside the container, aligned
  /// according to the given UnitPoint.
  ///
  /// Note: This mirrors how alignment guides work in SwiftUI — the origin of the
  /// rect shifts so that the point described by anchor within the container aligns
  /// to the same point in the rect.
  public func aligned(
    in container: CGSize,
    to anchor: UnitPoint = .center,
  ) -> CGRect {
    let origin = CGPoint(
      x: (container.width - width) * anchor.x,
      y: (container.height - height) * anchor.y,
    )
    return CGRect(origin: origin, size: size)
  }
  
  public func aligned(
    in container: CGRect,
    to anchor: UnitPoint = .center,
  ) -> CGRect {
    let baseOrigin = aligned(in: container.size, to: anchor).origin
    let origin = CGPoint(
      x: container.minX + baseOrigin.x,
      y: container.minY + baseOrigin.y,
    )
    return CGRect(origin: origin, size: size)
  }
}
