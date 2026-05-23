//
//  LegibilityDarkenModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/9/2025.
//

import SwiftUI

struct LegibilityDarkenAdjuster {
  static func adjust(
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

// MARK: - View Modifier


//// MARK: - Shape Style
//public struct LegibilityDarkenStyle: ShapeStyle {
//  let base: Color
//  let tint: Color
//  let strength: CGFloat
//  let hueShift: CGFloat
//
//  public func resolve(in environment: EnvironmentValues) -> Color {
//    /// Get the resolved color in the current environment
//    let resolved = tint.resolve(in: environment)
//    /// Convert to HSV using your project's helper
//    var hsv = HSVColour(resolved: resolved, name: nil)
//
//    /// Adjust values
//    let adjusted = LegibilityDarkenAdjuster.adjust(
//      hue: hsv.hue.value,
//      saturation: hsv.saturation,
//      brightness: hsv.brightness,
//      strength: strength,
//      hueShift: hueShift
//    )
//    hsv.saturation = adjusted.s.toUnitInterval
//    hsv.brightness = adjusted.v.toUnitInterval
//    hsv.hue = adjusted.h.toUnitIntervalCyclic
//
//    /// Make a new Color from HSV
//    let adjustedColor = hsv.swiftUIColour
//
//    let mixed = base.mixCompatible(with: adjustedColor, by: 0.5)
////    let mixed = base.mixCompatible(with: adjustedColor, by: 0.5)
//    return mixed
//  }
//}
//
//public struct QuickMixStyle: ShapeStyle {
//  let base: Color
//  let tint: Color
//  let strength: CGFloat
//  //  let hueShift: CGFloat
//
//  public func resolve(in environment: EnvironmentValues) -> Color {
//
//    return base.mixCompatible(with: tint, by: strength)
//    //    /// Get the resolved color in the current environment
//    //    let resolved = tint.resolve(in: environment)
//    //    /// Convert to HSV using your project's helper
//    //    var hsv = HSVColour(resolved: resolved, name: nil)
//    //
//    //    /// Adjust values
//    //    let adjusted = LegibilityDarkenAdjuster.adjust(
//    //      hue: hsv.hue.value,
//    //      saturation: hsv.saturation.value,
//    //      brightness: hsv.brightness.value,
//    //      strength: strength,
//    //      hueShift: hueShift
//    //    )
//    //    hsv.saturation = adjusted.s.toUnitInterval
//    //    hsv.brightness = adjusted.v.toUnitInterval
//    //    hsv.hue = adjusted.h.toUnitIntervalCyclic
//    //
//    //    /// Make a new Color from HSV
//    //    let adjustedColor = hsv.swiftUIColour
//    //
//    //    let mixed = base.mixCompatible(with: adjustedColor, by: 0.5)
//    //    return mixed
//  }
//}

/// `self` as Base colour
//extension Color {
//  public func legibilityDarken(
//    tint: Color = .blue.opacityMid,
//    strength: CGFloat = 0.5,
//    hueShift: CGFloat = 0
//  ) -> AnyShapeStyle {
//    AnyShapeStyle(
//      LegibilityDarkenStyle(
//        tint: tint,
//        strength: strength,
//        hueShift: hueShift
//      )
//    )
//  }
//}

//extension ShapeStyle where Self == Color {
//
//  public static func quickMix(
//    base: Color,
//    tint: Color,
//    strength: CGFloat = 0.5,
//  ) -> some ShapeStyle {
//    QuickMixStyle(
//      base: base,
//      tint: tint,
//      strength: strength,
//    )
//  }
//
//  public static func legibilityDarken(
//    base: Color = .black.opacityMid,
//    tint: Color = .blue.opacityLow,
//    strength: CGFloat = 0.5,
//    hueShift: CGFloat = 0
//  ) -> some ShapeStyle {
//    LegibilityDarkenStyle(
//      base: base,
//      tint: tint,
//      strength: strength,
//      hueShift: hueShift
//    )
//
//    //    AnyShapeStyle(
//    //    )
//  }
//}
