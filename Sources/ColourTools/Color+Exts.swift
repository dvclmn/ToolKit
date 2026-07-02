//
//  Color+Exts.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension Color {
  public init(hex: String) {
    guard let components = HexColor.components(from: hex) else {
      self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
      return
    }

    self.init(
      .sRGB,
      red: components.r,
      green: components.g,
      blue: components.b,
      opacity: components.a
    )
  }
}


extension Color: RGBAConvertible {
  /// Important: Assumes `SwiftUI/RGBColorSpace/sRGB` colour space
  public init(r: Double, g: Double, b: Double, a: Double, name: String? = nil) {
    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
  }
}
