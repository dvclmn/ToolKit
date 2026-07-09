//
//  QB+RoundedRectangular.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

struct QuickRoundedRectangularBackgroundModifier<S: RoundedRectangularShapeCompatible>: ViewModifier {
  @Environment(\.layoutPadding) private var layoutPadding

  let isEnabled: Bool
  let shape: S
  let glass: GlassTypeCompatible?
  let padding: CGFloat
  let tint: Color?
  
  func body(content: Content) -> some View {
    content
      .weightedPadding(layoutPadding ?? padding)
      .containerShapeCompatible(shape)
      .glassEffectCompatible(glass, in: shape)
      .clipShape(shape)
      .background {
        QuickBackgroundSurface(
          isEnabled: isEnabled,
          shape: shape,
          glass: glass,
          tint: tint,
        )
      }
  }
}
