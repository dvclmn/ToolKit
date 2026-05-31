//
//  Direction2D.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/1/2026.
//

import SwiftUI

public struct Direction2D: Sendable, Hashable {
  public let x: CGFloat
  public let y: CGFloat
}

extension Direction2D {
  public static let up = Direction2D(x: 0, y: -1)
  public static let down = Direction2D(x: 0, y: 1)
  public static let leading = Direction2D(x: -1, y: 0)
  public static let trailing = Direction2D(x: 1, y: 0)

  public static let centre = Direction2D(x: 0, y: 0)

  public static let topLeading = Direction2D(x: -1, y: -1)
  public static let topTrailing = Direction2D(x: 1, y: -1)
  public static let bottomLeading = Direction2D(x: -1, y: 1)
  public static let bottomTrailing = Direction2D(x: 1, y: 1)
}

extension Direction2D {
  public func offset(
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward,
  ) -> CGSize {
    let multiplier: CGFloat = (radialDirection == .outward) ? 1 : -1
    return CGSize(
      width: x * distance * multiplier,
      height: y * distance * multiplier,
    )
  }

  public func offset(
    axis: GeometryAxis,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward,
  ) -> CGFloat {
    let offset = offset(distance: distance, radial: radialDirection)
    return axis.isHorizontal ? offset.width : offset.height
  }

}

