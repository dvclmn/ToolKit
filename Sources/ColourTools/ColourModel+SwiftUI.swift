//
//  ColourModel+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

public protocol SwiftUIColourConvertible {
  var toColour: Color { get }
}

extension RGBColourSpace {
  public var swiftUIColourSpace: Color.RGBColorSpace {
    switch self {
      case .sRGB: .sRGB
      case .sRGBLinear: .sRGBLinear
      case .displayP3: .displayP3
    }
  }
}
