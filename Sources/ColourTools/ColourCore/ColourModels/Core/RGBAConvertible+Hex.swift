//
//  RGBAConvertible+Hex.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

extension RGBAConvertible {

  /// Creates an RGBA-compatible colour value from a hex string.
  ///
  /// Hex parsing produces component values only. Wrap the result in
  /// ``NamedColour`` if the hex string came from a labelled palette or token.
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
  public init?(hex: String) {
    guard let components = HexColor.components(from: hex) else { return nil }
    self.init(
      r: components.r,
      g: components.g,
      b: components.b,
      a: components.a
    )
  }
}

extension String {

  /// Removes `#` or whitespace if present etc
  public var toSanitisedHex: String {
    HexColor.sanitisedHexString(self)
  }
}
