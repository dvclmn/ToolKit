//
//  Compat+ConcentricRectangle.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

extension View {
  /// Clips this view to a concentric rectangle on current systems, falling back
  /// to `ContainerRelativeShape` on older systems.
  @ViewBuilder
  public func concentricClipShapeCompatible(
    cornerStyle: RoundedRectangularCornerStyleCompatible = .concentric(),
    isUniform: Bool = false
  ) -> some View {
    if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
      clipShape(
        ConcentricRectangle(
          corners: cornerStyle.nativeCornerStyle,
          isUniform: isUniform,
        )
      )
    } else {
      clipShape(ContainerRelativeShape())
    }
  }

  /// Draws a shaped background that resolves against the nearest compatible
  /// container shape.
  ///
  /// On macOS 26 and newer this uses SwiftUI's native concentric rectangle.
  /// Older systems fall back to `ContainerRelativeShape`; `cornerStyle` and
  /// `isUniform` are native concentricity controls and have no older-system
  /// equivalent.
  @ViewBuilder
  public func concentricBackgroundCompatible<S: ShapeStyle>(
    _ style: S,
//    isEnabled: Bool = true,
    cornerStyle: RoundedRectangularCornerStyleCompatible = .concentric(),
    isUniform: Bool = false
  ) -> some View {
//    if isEnabled {
      if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, visionOS 26.0, *) {
        background(
          style,
          in: ConcentricRectangle(
            corners: cornerStyle.nativeCornerStyle,
            isUniform: isUniform,
          )
        )
      } else {
        background(style, in: ContainerRelativeShape())
      }
//    } else {
//      self
//    }
  }
}
