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
  let style: QuickBackgroundStyle

  func body(content: Content) -> some View {
    content
      .containerShapeCompatible(shape)
      .modifier(QuickBackgroundBaseModifier(isEnabled: isEnabled, shape: shape, style: style))
  }
}
