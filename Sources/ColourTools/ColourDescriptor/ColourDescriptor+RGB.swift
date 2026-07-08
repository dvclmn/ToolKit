//
//  ColourDescriptor+RGB.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

extension ColourDescriptor {
  /// Returns a concrete RGB representation when the descriptor already contains
  /// component data that can be flattened without resolving a UI framework colour.
  ///
  /// System colours return `nil` because they are symbolic platform colours.
  /// Resolve them through the SwiftUI or AppKit bridge properties instead.
  public var rgbColour: RGBColour? {
    switch self {
      case .hex(let hex):
          return .init(hex: hex)
        
      case .rgb(let rgbColour):
          return rgbColour
        
      case .rgbRaw(let r, let g, let b, let a):
          return .init(red: r, green: g, blue: b, alpha: a)
        
      case .hsv(let hsvColour):
          return .init(fromHSV: hsvColour)
        
      case .hsvRaw(let h, let s, let v, let a):
        let hsv = HSVColour(hue: h, saturation: s, brightness: v, alpha: a)
        return .init(fromHSV: hsv)
        
      case .system:
        return nil

      case .grey(let double, let opacity):
        return .gray(double, alpha: opacity)
    }
  }
}
