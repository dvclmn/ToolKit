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
