//
//  LegibilityDarkenModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

public struct LegibilityDarkenModifier: ViewModifier {
  let base: Color
  let strength: CGFloat
  let hueShift: CGFloat
  
  public func body(content: Content) -> some View {
    ZStack {
      base
      content
    }
    .saturation(
      LegibilityDarkenAdjuster.adjust(
        strength: strength,
        hueShift: hueShift
      ).s
    )
    .brightness(
      LegibilityDarkenAdjuster.adjust(
        strength: strength,
        hueShift: hueShift
      ).v
    )
    .hueRotation(
      .degrees(
        LegibilityDarkenAdjuster.adjust(
          strength: strength,
          hueShift: hueShift
        ).h * 360))
    
  }
}
extension View {
  public func legibilityDarken(
    base: Color,
    tint: Color = Color.blue.opacity(0.4),
    strength: CGFloat = 0.5,
    hueShift: CGFloat = 0
  ) -> some View {
    self.modifier(
      LegibilityDarkenModifier(
        base: base,
        strength: strength,
        hueShift: hueShift
      )
    )
  }
}
