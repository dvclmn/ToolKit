//
//  CGPoint+Stretched.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/1/2026.
//


import Foundation

// MARK: - Stretch out an Axis
/// Options that control how a point is stretched along an axis.
public struct StretchOptions: OptionSet, Sendable {
  public let rawValue: Int

  /// Treats positions as unit coordinates before stretching.
  static let normalised = StretchOptions(rawValue: 1 << 0)

  /// Clamps the stretched result.
  public static let clamped = StretchOptions(rawValue: 2 << 0)

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}
extension CGPoint {

  /// Maps one axis of this point into a stretched coordinate range.
  ///
  /// Use this when the response range should be wider or narrower than the
  /// point's raw movement across a view or geometry space.
  public func stretchedPosition(
    _ axis: GeometryAxis,
    in size: CGSize,
    stretchFactor: CGFloat,
    options: StretchOptions = [],
  ) -> CGFloat {

    let rawLocation: CGFloat =
      switch axis {
        case .horizontal: self.x
        case .vertical: self.y
      }

    let viewLength: CGFloat =
      switch axis {
        case .horizontal: size.width
        case .vertical: size.height
      }

    let normalisedValue =
      options.contains(.normalised) ? rawLocation / viewLength : rawLocation

    let centered: CGFloat
    let result: CGFloat

    if options.contains(.normalised) {
      centered = normalisedValue - 0.5
      result = centered * stretchFactor + 0.5
    } else {
      centered = rawLocation - (viewLength / 2)
      result = centered * stretchFactor + (viewLength / 2)
    }

    if options.contains(.clamped) {
      return result.clamped(to: 0...1)
    }

    return result
  }

  /// Hint: use extension `toCGRect` on `CGSize` for convenient
  /// conversion, if origin is `zero`.
  public func mapped(to destination: CGRect) -> CGPoint {
    let result = CGPoint(
      x: destination.origin.x + (self.x * destination.width),
      y: destination.origin.y + (self.y * destination.height),
    )
    return result
  }

  public func remapped(from oldRect: CGRect, to newRect: CGRect) -> CGPoint {
    let normalisedX = (self.x - oldRect.minX) / oldRect.width
    let normalisedY = (self.y - oldRect.minY) / oldRect.height

    let newX = newRect.minX + (normalisedX * newRect.width)
    let newY = newRect.minY + (normalisedY * newRect.height)

    return CGPoint(x: newX, y: newY)
  }

}
