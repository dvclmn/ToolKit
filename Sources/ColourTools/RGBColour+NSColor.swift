//
//  RGBColour+NSColor.swift
//  ToolKit
//

#if canImport(AppKit)
import AppKit

extension RGBColour {
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
