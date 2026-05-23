//
//  LegibilityDarkenModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/9/2025.
//

import Foundation

package struct LegibilityDarkenAdjuster {
  package static func adjust(
    hue h: CGFloat = 0.0,
    saturation s: CGFloat = 1.0,
    brightness v: CGFloat = 0.0,
    strength: CGFloat,
    hueShift: CGFloat
  ) -> (h: CGFloat, s: CGFloat, v: CGFloat) {
    let newSaturation: CGFloat = (s * (1.0 + 0.2 * strength)).clamped(to: 0...1)
    let newBrightness: CGFloat = (v + -0.1 * strength).clamped(to: 0...1)
    let newHue: CGFloat = (h + (hueShift / 360)).truncatingRemainder(dividingBy: 1)
    return (newHue, newSaturation, newBrightness)
  }
}
