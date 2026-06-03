//
//  DigitPadding.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2025.
//

import Foundation

extension String {

  /// Pads the string on the left until it reaches the requested length.
  ///
  /// For example, `"5".leftPadded(to: 4, with: "0")` returns `"0005"`.
  public func leftPadded(
    to length: Int,
    with character: Character = " "
  ) -> String {
    let currentWidth = count
    if currentWidth >= length { return self }
    let padding = String(repeating: character, count: length - currentWidth)
    return padding + self
  }
}

extension Int {
  /// Converts the integer to a string, then left-pads it to the requested length.
  public func leftPadded(
    to length: Int,
    with character: Character = " "
  ) -> String {
    String(self).leftPadded(to: length, with: character)
  }
}
