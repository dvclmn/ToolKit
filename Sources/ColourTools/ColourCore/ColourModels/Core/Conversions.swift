//
//  Conversions.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/6/2025.
//

import Foundation

extension HSVColour {

  /// From existing `RGBColour` instance
  public init(fromRGB rgb: RGBColour) {
    let rgb = rgb.normalised
    self.init(
      fromRGB: rgb.red,
      g: rgb.green,
      b: rgb.blue,
      a: rgb.alpha
    )
  }

  public init(
    fromRGB r: Double,
    g: Double,
    b: Double,
    a: Double,
    name: String? = nil
  ) {

    let red = ColourComponentNormalisation.clampUnit(r)
    let green = ColourComponentNormalisation.clampUnit(g)
    let blue = ColourComponentNormalisation.clampUnit(b)
    let alpha = ColourComponentNormalisation.clampUnit(a)

    let maxValue = max(red, green, blue)
    let minValue = min(red, green, blue)
    let delta = maxValue - minValue

    let hue: Double
    if delta == 0 {
      hue = 0
    } else if maxValue == red {
      hue = ((green - blue) / delta + (green < blue ? 6 : 0)) / 6
    } else if maxValue == green {
      hue = ((blue - red) / delta + 2) / 6
    } else {
      hue = ((red - green) / delta + 4) / 6
    }

    let saturation = maxValue == 0 ? 0 : delta / maxValue

    self.init(
      hue: hue,
      saturation: saturation,
      brightness: maxValue,
      alpha: alpha,
      name: name
    )
  }
}
