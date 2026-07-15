//
//  QuickBackgroundModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/5/2025.
//

import SwiftUI

struct QuickBackgroundModifier<S: Shape>: ViewModifier {
  @Environment(\.layoutPadding) private var layoutPadding

  let isEnabled: Bool
  let shape: S
  let glass: GlassTypeCompatible?
  let padding: CGFloat
  let tint: Color?

  func body(content: Content) -> some View {
    content
      .weightedPadding(layoutPadding ?? padding)
      .glassEffectCompatible(glass, in: shape)
      .clipShape(shape)
      .background {
        if glass == nil {
          QuickBackgroundSurface(
            isEnabled: isEnabled,
            shape: shape,
            tint: tint,
          )
        }
      }
  }
}
