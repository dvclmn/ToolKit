//
//  Direction+Exts.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/5/2026.
//

import CoreTools
import SwiftUI

extension Direction {

  public var toSwiftUIAxis: Axis {
    isVertical ? .vertical : .horizontal
  }
  
  public var keyEquivalent: KeyEquivalent {
    switch self {
      case .up: .upArrow
      case .down: .downArrow
      case .left: .leftArrow
      case .right: .rightArrow
    }
  }
}

extension UnitPoint {
  
  /// If left nil, the radial direction will be inferred from `self`,
  /// using a product of the origin (0.5) and the provided coordinate's value
  func directionMultiplier(
    for axis: GeometryAxis,
    mapping: AxisMapping = .default,
    radial radialDirection: RadialDirection? = nil,
  ) -> CGFloat {
    let axisValue = value(along: axis, mapping: mapping)
    
    /// If an explicit radial direction is provided, use it directly
    if let radialDirection {
      return radialDirection.multiplier
    }
    
    /// No explicit radial direction: infer based on position relative to centre (0.5)
    if axisValue < 0.5 { return +1 }
    if axisValue > 0.5 { return -1 }
    return 0
  }
}

extension Direction2D {
  
  /// Consider similarities (possibly merging etc), based on extension
  /// `CGPoint/repositioned(to:in:)`
  public func positioned(
    from origin: CGPoint,
    alignment: Alignment,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward,
  ) -> CGPoint {
    let delta = alignment.offset(distance: distance, radial: radialDirection)
    return CGPoint(
      x: origin.x + delta.width,
      y: origin.y + delta.height,
    )
  }
}

extension Alignment {
  
  public var direction: Direction2D {
    switch self {
      case .top: .up
      case .bottom: .down
      case .leading: .leading
      case .trailing: .trailing
      case .topLeading: .topLeading
      case .topTrailing: .topTrailing
      case .bottomLeading: .bottomLeading
      case .bottomTrailing: .bottomTrailing
      case .center: .centre
      default: .centre
    }
  }
  
  public func offset(
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward,
  ) -> CGSize {
    direction.offset(distance: distance, radial: radialDirection)
  }
  
  public func offset(
    axis: GeometryAxis,
    distance: CGFloat,
    radial radialDirection: RadialDirection = .outward,
  ) -> CGFloat {
    direction.offset(axis: axis, distance: distance, radial: radialDirection)
  }
  
}

extension ViewDimensions {
  public func offset(
    for alignment: Alignment,
    axis: GeometryAxis,
    magnitude: CGFloat,  // As a factor, e.g. 0.2
    radial radialDirection: RadialDirection = .outward,
  ) -> CGFloat {
    
    let viewLength = axis.isHorizontal ? self.width : self.height
    let offsetAmount: CGFloat = viewLength * magnitude
    let targetAlignment = getAlignment(alignment)
    let offset = targetAlignment.offset(
      axis: axis,
      distance: offsetAmount,
      radial: radialDirection,
    )
    return axis.isHorizontal
    ? self[targetAlignment.horizontal] + offset
    : self[targetAlignment.vertical] + offset
    
  }
  
  private func getAlignment(
    _ alignment: Alignment
  ) -> Alignment {
    //    let excluded: [Alignment] = [.center]
    let toFlip: [Alignment] = [.leading, .trailing, .top, .bottom]
    return toFlip.contains(alignment) ? alignment.toOpposing : alignment
  }
}
