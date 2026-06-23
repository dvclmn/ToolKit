//
//  HSVColour+NSColor.swift
//  ToolKit
//

#if canImport(AppKit)
import AppKit

extension HSVColour {
  public var toNSColor: NSColor {
    NSColor(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha,
    )
  }
}
#endif
