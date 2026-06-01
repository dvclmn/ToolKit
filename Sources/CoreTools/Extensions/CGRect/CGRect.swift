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

  /// Creates a rectangle from two points, ensuring positive width and height
  /// Useful for drag operations like marquee selection where the drag direction is unknown
  ///
  /// Note: previous methods `reversible`, `fromPoints(_:_:)`,
  /// `between(point1:point2:)`
  public static func boundingRect(
    from start: CGPoint, to end: CGPoint,
  ) -> CGRect {
    let size = CGSize(
      width: end.x - start.x,
      height: end.y - start.y,
    )
    return CGRect(origin: start, size: size).standardized
  }

  package static let exampleZeroOrigin100x100 = CGRect(
    origin: .zero, size: CGSize(width: 100, height: 100),
  )

  // Edges
  public var leadingEdge: CGFloat { minX }
  public var trailingEdge: CGFloat { maxX }
  public var topEdge: CGFloat { minY }
  public var bottomEdge: CGFloat { maxY }

  // Dimensions
  // TODO: These need to be passed through the AxisMapping pipeline, to be safer
  public var horizontal: ClosedRange<CGFloat> { minX...maxX }
  public var vertical: ClosedRange<CGFloat> { minY...maxY }

}

// MARK: - Convenience initialisers
extension CGRect {

  /// Creates a rect with an origin of zero, and size from provided `size`
  public init(fromSize size: CGSize) {
    self.init(origin: .zero, size: size)
  }

  /// Useful for occasions where origin and size properties
  /// are already defined, just need to be plugged in,
  /// and an extra-quick init is helpful
  public init(_ origin: CGPoint, _ size: CGSize) {
    self.init(origin: origin, size: size)
  }

  /// Creates a rectangle with the given size, centered within the container size
  public init(size: CGSize, centeredIn containerSize: CGSize) {
    let origin = CGPoint(
      x: (containerSize.width - size.width) / 2,
      y: (containerSize.height - size.height) / 2,
    )
    self.init(origin: origin, size: size)
  }

}
