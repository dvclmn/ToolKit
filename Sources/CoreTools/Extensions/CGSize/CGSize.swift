//
//  CGSize.swift
//  Collection
//
//  Created by Dave Coleman on 12/11/2024.
//

import CoreGraphics
import Foundation

extension CGSize: @retroactive Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(width)
    hasher.combine(height)
  }
}

extension CGSize {
  public init<T: BinaryFloatingPoint>(fromLength length: T) {
    self.init(width: CGFloat(length), height: CGFloat(length))
  }
}

extension CGSize {

  @available(
    *, deprecated, renamed: "magnitude",
    message: "Renamed to avoid confusion with Axis mapping methods, use 'magnitude'"
  )
  public var length: CGFloat { sqrt(width * width + height * height) }

  /// The Euclidean magnitude of the size when treated as a vector.
  public var magnitude: CGFloat { sqrt(width * width + height * height) }

  @available(
    *, deprecated, renamed: "normalisedMagnitude",
    message: "Renamed to avoid confusion with Axis mapping methods, use 'normalisedMagnitude'"
  )
  public var normalisedLength: CGSize { length > 0 ? self / length : .zero }

  /// A unit-length size in the same direction, or `.zero` for a zero magnitude.
  public var normalisedMagnitude: CGSize { magnitude > 0 ? self / magnitude : .zero }


  /// The greater of `width` and `height`.
  public var longestDimension: CGFloat { max(width, height) }

  /// The lesser of `width` and `height`.
  public var shortestDimension: CGFloat { min(width, height) }

  /// Returns the offset needed to centre a child of the given size within this container.
  /// Aka: The vector from container origin to child origin that equalises margins.
  /// Negative offsets indicate the child is larger than the container and will overflow equally on all sides.
  public func centringOffset(forChild childSize: CGSize) -> CGSize {
    guard
      width.isFinite, height.isFinite,
      childSize.width.isFinite, childSize.height.isFinite
    else { return .zero }

    return CGSize(
      width: (width - childSize.width) / 2,
      height: (height - childSize.height) / 2,
    )
  }

  /// Returns a new size reduced evenly on all four sides by the specified inset value,
  /// and clamped to min value of `0`.
  /// - Parameter inset: The amount to inset from all edges. Width and height are each reduced by 2x this value, 1x for each opposing side
  /// - Returns: A new CGSize with the inset applied
  public func inset(by inset: CGFloat) -> CGSize {
    return CGSize(
      width: max(0, width - (inset * 2)),
      height: max(0, height - (inset * 2)),
    )
  }

  public var diagonalLength: CGFloat {
    hypot(width, height)
  }

  public func clampBothDimensions(toMin length: CGFloat) -> CGSize {
    let width = max(length, width)
    let height = max(length, height)
    return CGSize(width: width, height: height)
  }

  /// Returns the centre point of the size
  public var midpoint: CGPoint {
    return CGPoint(x: width / 2, y: height / 2)
  }

  public var halved: CGSize {
    return CGSize(width: width / 2, height: height / 2)
  }
  
  
  public init(fromLength length: CGFloat) {
    self.init(width: length, height: length)
  }

}
