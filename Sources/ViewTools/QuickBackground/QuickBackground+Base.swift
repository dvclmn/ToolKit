//
//  QuickBackground+Base.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/9/2026.
//

import SwiftUI

struct QuickBackgroundBaseModifier<S: Shape>: ViewModifier {

  let isEnabled: Bool
  let shape: S
  let style: QuickBackgroundStyle

  func body(content: Content) -> some View {
    content
      .glassEffectCompatible(style.glassEffect, in: shape)
      .clipShape(shape)
      .background {
        switch style {
          case .standard(let tint):
            QuickBackgroundSurface(
              isEnabled: isEnabled,
              shape: shape,
              tint: tint,
            )

          case .glass:
            EmptyView()
        }
      }
  }
}
