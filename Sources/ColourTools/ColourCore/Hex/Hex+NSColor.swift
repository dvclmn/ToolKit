//
//  Hex+NSColor.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/11/2025.
//

// Full credit to Wilhelm Oks
// See https://github.com/WilhelmOks/HexColor
/**
 *  HexColor
 *  Copyright (c) Wilhelm Oks 2020
 *  Licensed under the MIT license (see LICENSE file)
 */

#if os(macOS)

import AppKit

public extension NSColor {
  static func fromHexString(_ hex: String, alpha: CGFloat? = nil) -> NSColor? {
    guard let components = HexColor.components(from: hex) else { return nil }
    
    if let alpha = alpha {
      return NSColor(
        red:   CGFloat(components.r),
        green: CGFloat(components.g),
        blue:  CGFloat(components.b),
        alpha: alpha)
    } else {
      return NSColor(
        red:   CGFloat(components.r),
        green: CGFloat(components.g),
        blue:  CGFloat(components.b),
        alpha: CGFloat(components.a))
    }
  }
}

#endif
