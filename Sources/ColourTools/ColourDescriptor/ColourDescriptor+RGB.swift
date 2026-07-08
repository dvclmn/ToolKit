//
//  ColourDescriptor+RGB.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

extension ColourDescriptor {
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
        
      case .system(let systemColour, let opacity):
        <#code#>
      case .grey(let double, let opacity):
        <#code#>
    }
  }
}
