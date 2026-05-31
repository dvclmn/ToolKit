//
//  Color+Exts.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools
import ColourTools

extension Color {
  public init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    self.init(
      .sRGB,
      red: Double((int & 0xFF0000) >> 16) / 255,
      green: Double((int & 0x00FF00) >> 8) / 255,
      blue: Double(int & 0x0000FF) / 255
    )
  }
}


extension Color: RGBAConvertible {
  /// Important: Assumes `SwiftUI/RGBColorSpace/sRGB` colour space
  public init(r: Double, g: Double, b: Double, a: Double, name: String? = nil) {
    self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
  }
}
