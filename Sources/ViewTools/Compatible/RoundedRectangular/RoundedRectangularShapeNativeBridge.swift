//
//  RoundedRectangularShapeNativeBridge.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

@available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *)
struct RoundedRectangularShapeNativeBridge<Base: InsettableShape>: RoundedRectangularShape {
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
  var nativeCornerStyle: Edge.Corner.Style {
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
  var nativeCorners: RoundedRectangularShapeCorners {
    .init(
      topLeading: topLeading.nativeCornerStyle,
      topTrailing: topTrailing.nativeCornerStyle,
      bottomLeading: bottomLeading.nativeCornerStyle,
      bottomTrailing: bottomTrailing.nativeCornerStyle,
    )
  }
}
