//
//  QB+RoundedRectangular.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

struct QuickRoundedRectangularBackgroundModifier<S: RoundedRectangularShapeCompatible>: ViewModifier {
  let isEnabled: Bool
  let shape: S
  let glass: GlassTypeCompatible?
  let padding: CGFloat
  let tint: Color?
  
  func body(content: Content) -> some View {
    content
      .modifier(
        QuickBackgroundModifier(
          isEnabled: isEnabled,
          shape: shape,
          glass: glass,
          padding: padding,
          tint: tint,
        )
      )
      .containerShapeCompatible(shape)
  }
}
