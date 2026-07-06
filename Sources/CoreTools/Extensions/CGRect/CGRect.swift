//
//  CGRect.swift
//  Collection
//
//  Created by Dave Coleman on 9/12/2024.
//

import Foundation

extension CGRect {

  public var isSizeZero: Bool { width == 0 && height == 0 }

  public var isStandardized: Bool {
    return !isNull && !isInfinite
      && origin.x.isFinite && origin.y.isFinite
      && width.isFinite && height.isFinite
      && width >= 0 && height >= 0
  }

  /// Returns a rectangle that encompasses both this rectangle and the provided rectangle
  public func expanded(toInclude rect: CGRect) -> CGRect {
    union(rect)
  }

  /// Creates a standardised rectangle from two points.
  ///
  /// Useful for drag operations, such as marquee selection, where the drag
  /// direction is unknown.
  public static func boundingRect(
    from start: CGPoint, to end: CGPoint,
  ) -> CGRect {
    let size = CGSize(
      width: end.x - start.x,
      height: end.y - start.y,
    )
    return CGRect(origin: start, size: size).standardized
  }

  // MARK: Edges
  public var leadingEdge: CGFloat { minX }
  public var trailingEdge: CGFloat { maxX }
  public var topEdge: CGFloat { minY }
  public var bottomEdge: CGFloat { maxY }

}

// MARK: - Convenience inits

extension CGRect {

  /// Creates a rectangle with a zero origin and the provided size.
  public init(fromSize size: CGSize) {
    self.init(origin: .zero, size: size)
  }

  /// Creates a rectangle from an origin and size without argument labels.
  public init(_ origin: CGPoint, _ size: CGSize) {
    self.init(origin: origin, size: size)
  }

  /// Creates a rectangle with `size` centred in `containerSize`.
  public init(size: CGSize, centredIn containerSize: CGSize) {
    let origin = CGPoint(
      x: (containerSize.width - size.width) / 2,
      y: (containerSize.height - size.height) / 2,
    )
    self.init(origin: origin, size: size)
  }

}
