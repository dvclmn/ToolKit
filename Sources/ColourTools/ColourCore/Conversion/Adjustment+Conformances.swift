//
//  Adjustment+Conformances.swift
//  ToolKit
//
//  Created by Dave Coleman on 17/2/2026.
//

import CoreTools
import Foundation

extension HSVColour: HSVAdjustable {

  public init(fromHSV hsv: HSVColour) {
    self = hsv.normalised
  }

  public var toHSV: HSVColour { self }
}

extension RGBColour: HSVAdjustable {

  /// Convert to HSV, preserving `previous.hue` when the converted hue is undefined.
  public func toHSV(preservingHueFrom previous: HSVColour?) -> HSVColour {
    let converted = self.toHSV
    guard let previous else { return converted }
    return previous.mergingPreservingHue(converted)
  }

  public var toHSV: HSVColour { HSVColour(fromRGB: self) }

  public init(fromHSV hsv: HSVColour) {
    let hsv = hsv.normalised
    let hueScaled = hsv.hue * 6
    let hueSegment = Int(floor(hueScaled)) % 6
    let fraction = hueScaled - floor(hueScaled)

    // p = the floor / minimum value
    // The baseline "neutral" color value. Represents the lowest possible value
    // any of the RGB channels can drop to for this specific color.
    // Entirely dictated by saturation. If saturation is 100% (1.0),
    // p becomes 0 (fully saturated). If saturation is 0% (0.0),
    // p becomes equal to the brightness, resulting in a shade of gray.
    let p = hsv.brightness * (1 - hsv.saturation)

    // q = the descending / sloping down value
    // q calculates a value that is smoothly fading out
    // from left to right across the current hue sector.
    // As the fraction grows from 0.0 to 1.0, the value of q
    // slopes downward from the maximum brightness down toward p.
    let q = hsv.brightness * (1 - fraction * hsv.saturation)

    // t = the ascending / sloping up value
    // This is the exact inverse of q. It calculates a value that is
    // smoothly fading in as you move across the hue sector.
    // As the fraction grows from 0.0 to 1.0, the value of t slopes upward,
    // rising from the minimum floor p up to the maximum brightness.
    let t = hsv.brightness * (1 - (1 - fraction) * hsv.saturation)

    let v = hsv.brightness

    let red: Double
    let green: Double
    let blue: Double

    switch hueSegment {
      case 0:
        red = v
        green = t
        blue = p
      case 1:
        red = q
        green = v
        blue = p
      case 2:
        red = p
        green = v
        blue = t
      case 3:
        red = p
        green = q
        blue = v
      case 4:
        red = t
        green = p
        blue = v
      default:
        red = v
        green = p
        blue = q
    }

    self.init(
      r: red,
      g: green,
      b: blue,
      a: hsv.alpha,
      name: hsv.name,
    )
  }

}
