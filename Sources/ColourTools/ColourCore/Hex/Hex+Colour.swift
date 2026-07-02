//
//  Hex+Colour.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/11/2025.
//

/**
 *  HexColor
 *  Copyright (c) Wilhelm Oks 2020
 *  Licensed under the MIT license (see LICENSE file)
 */

import CoreGraphics
import Foundation

public struct HexColor {
  private init() {}

  private static let invalidHexCharactersSet = CharacterSet(charactersIn: "0123456789abcdefABCDEF").inverted

  public static func components(from hex: String) -> (r: Double, g: Double, b: Double, a: Double)? {
    guard let integer = intFromHexString(hex) else { return nil }
    return rgbaComponents(from: integer)
  }

  public static func intFromHexString(_ hex: String) -> UInt64? {
    var s = sanitisedHexString(hex)

    guard !s.isEmpty else {
      return nil
    }

    guard s.rangeOfCharacter(from: invalidHexCharactersSet) == nil else {
      return nil
    }

    if s.count == 3 {  // shorthand 3 digit notation
      s = s + "f"  // add alpha
    }

    if s.count == 4 {  // shorthand 3 digit notation + 1 alpha digit
      s = s.reduce("") { $0 + String($1) + String($1) }  //duplicate all digits
    }

    if s.count == 6 {  // normal notation without alpha
      s = s + "ff"  // add alpha
    }

    guard s.count == 8 else {
      return nil
    }

    let scanner = Scanner(string: s)

    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    return rgb
  }

  public static func sanitisedHexString(_ hex: String) -> String {
    var s = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    if s.hasPrefix("#") {
      s = String(s.dropFirst())
    }
    return s
  }

  public static func rgbaComponents(from integer: UInt64) -> (r: Double, g: Double, b: Double, a: Double) {
    let maxValue = Double(255)
    return (
      r: Double((integer & 0xFF000000) >> 24) / maxValue,
      g: Double((integer & 0xFF0000) >> 16) / maxValue,
      b: Double((integer & 0xFF00) >> 8) / maxValue,
      a: Double((integer & 0xFF)) / maxValue
    )
  }

  public static func rgbaFromInt(_ integer: UInt64) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    let components = rgbaComponents(from: integer)
    return (
      r: CGFloat(components.r),
      g: CGFloat(components.g),
      b: CGFloat(components.b),
      a: CGFloat(components.a)
    )
  }
}
