//
//  ColourDescriptor+RGB.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

extension ColourDescriptor {
  public var rgbColour: RGBColour {
    switch self {
      case .hex(let hex, let opacity):
          .init(hex: hex)
      case .rgb(let rGBColour):
        <#code#>
      case .rgbRaw(let r, let g, let b, let a):
        <#code#>
      case .hsv(let hSVColour):
        <#code#>
      case .hsvRaw(let h, let s, let v, let a):
        <#code#>
      case .system(let systemColour, let opacity):
        <#code#>
      case .grey(let double, let opacity):
        <#code#>
    }
  }
}
