//
//  QuickBackgroundModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 19/5/2025.
//

import SwiftUI

struct QuickShapeBackgroundModifier<S: Shape>: ViewModifier {
  @Environment(\.layoutPadding) private var layoutPadding

  let isEnabled: Bool
  let shape: S
  let style: QuickBackgroundStyle

  func body(content: Content) -> some View {
    content
      .modifier(
        QuickBackgroundBaseModifier(
          isEnabled: isEnabled,
          shape: shape,
          style: style,
        )
      )
  }
}
