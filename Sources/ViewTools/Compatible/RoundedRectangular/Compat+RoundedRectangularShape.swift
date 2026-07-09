//
//  Compat+RoundedRectangularShape.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

public protocol RoundedRectangularShapeCompatible: InsettableShape {
  /// Resolved rounded-rectangle corners for the proposed size.
  ///
  /// Return `nil` when the shape cannot truthfully describe itself as a rounded
  /// rectangle. Size-dependent shapes such as capsules should use `nil` size as
  /// their best approximation.
  nonisolated func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible?
}

extension View {
  //  @ViewBuilder
  //  public func containerShapeCompatible<S: InsettableShape>(_ shape: S) -> some View {
  //    containerShape(shape)
  //  }

  @ViewBuilder
  public func containerShapeCompatible<S: RoundedRectangularShapeCompatible>(_ shape: S) -> some View {
    if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
      containerShape(
        RoundedRectangularShapeNativeBridge(
          shape,
          corners: { shape.cornersCompatible(in: $0) },
        )
      )
    } else {
      containerShape(shape)
    }
  }
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *)
private struct RoundedRectangularShapeNativeBridge<Base: InsettableShape>: RoundedRectangularShape {
  var base: Base
  let corners: @Sendable (CGSize?) -> RoundedRectangularShapeCornersCompatible?

  init(
    _ base: Base,
    corners: @escaping @Sendable (CGSize?) -> RoundedRectangularShapeCornersCompatible?,
  ) {
    self.base = base
    self.corners = corners
  }

  nonisolated func path(in rect: CGRect) -> Path {
    base.path(in: rect)
  }

  var animatableData: Base.AnimatableData {
    get { base.animatableData }
    set { base.animatableData = newValue }
  }

  nonisolated func inset(by amount: CGFloat) -> RoundedRectangularShapeNativeBridge<Base.InsetShape> {
    let currentCorners = corners

    return .init(
      base.inset(by: amount),
      corners: { currentCorners($0)?.inset(by: amount) },
    )
  }

  nonisolated func corners(in size: CGSize?) -> RoundedRectangularShapeCorners? {
    corners(size)?.nativeCorners
  }
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *)
extension RoundedRectangularCornerStyleCompatible {
  fileprivate var nativeCornerStyle: Edge.Corner.Style {
    switch self {
      case .fixed(let radius):
        .fixed(radius)
      case .concentric(let minimum):
        .concentric(minimum: minimum?.nativeCornerStyle)
    }
  }
}

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *)
extension RoundedRectangularShapeCornersCompatible {
  fileprivate var nativeCorners: RoundedRectangularShapeCorners {
    .init(
      topLeading: topLeading.nativeCornerStyle,
      topTrailing: topTrailing.nativeCornerStyle,
      bottomLeading: bottomLeading.nativeCornerStyle,
      bottomTrailing: bottomTrailing.nativeCornerStyle,
    )
  }
}
