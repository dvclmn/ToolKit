//
//  RGBColour+NSColor.swift
//  ToolKit
//

#if canImport(AppKit)
import AppKit

extension RGBColour {
  public init?(nsColor: NSColor, colourSpace: NSColorSpace = .sRGB) {
    guard let colour = nsColor.usingColorSpace(colourSpace) else {
      return nil
    }

    self.init(
      red: colour.redComponent,
      green: colour.greenComponent,
      blue: colour.blueComponent,
      alpha: colour.alphaComponent,
    )
  }

  public var toNSColor: NSColor {
    NSColor(
      colorSpace: colourSpace.nsColorSpace,
      components: [red, green, blue, alpha],
      count: 4,
    )
  }
}

extension RGBColourSpace {
  fileprivate var nsColorSpace: NSColorSpace {
    switch self {
      case .sRGB:
        .sRGB
      case .sRGBLinear:
        if let cgColorSpace = CGColorSpace(name: CGColorSpace.extendedLinearSRGB),
          let nsColorSpace = NSColorSpace(cgColorSpace: cgColorSpace)
        {
          nsColorSpace
        } else {
          .sRGB
        }
      case .displayP3:
        .displayP3
    }
  }
}
#endif
