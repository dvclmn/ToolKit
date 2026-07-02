//
//  RGBAConvertible+Hex.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

extension RGBAConvertible {

  /// Create an RGBA-compatible colour value from a hex string.
  /// Supports the following formats:

  /// 1. 3-digit hex (`RGB`)
  /// 2. 4-digit hex (`RGBA`)
  /// 3. 6-digit hex (`RRGGBB`)
  /// 4. 8-digit hex (`RRGGBBAA`)
  ///
  /// 6-digit hex (RGB)
  /// `let red = RGBColour(hex: "FE6057")`
  ///
  /// 3-digit hex (RGB)
  /// `let blue = RGBColour(hex: "00F")`
  ///
  /// 8-digit hex (`RRGGBBAA`)
  /// `let transparentGreen = RGBColour(hex: "00FF0080")`
  public init?(hex: String, name: String? = nil) {
    guard let components = HexColor.components(from: hex) else { return nil }
    self.init(
      r: components.r,
      g: components.g,
      b: components.b,
      a: components.a,
      name: name
    )
  }
}

extension String {

  /// Removes `#` or whitespace if present etc
  public var toSanitisedHex: String {
    HexColor.sanitisedHexString(self)
  }
}
