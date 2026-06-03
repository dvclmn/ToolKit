//
//  WidthCounterStyle.swift
//  StringTools
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation

/// Generates textual width guides for fixed-width output.
public struct WidthCounter {
  let width: Int
  
  /// Creates a width counter for a target width.
  public init(width: Int) {
    self.width = width
  }

  /// The style of guide to generate.
  public enum Style: Sendable {
    case ruler
    case digits
  }

  /// Builds the guide as an attributed string.
  public func widthCounter(style: Style) -> AttributedString {

    var result = AttributedString()

    switch style {

      case .digits:

        let fullOutput = self.generateDigitCounter()
        result.append(fullOutput.tens, addsLineBreak: true)

        // Specify false so the guide has no trailing line break.
        result.append(fullOutput.ones, addsLineBreak: false)

      case .ruler:

        let compactOutput = self.generateCompactCounter()

        result.append(compactOutput, addsLineBreak: false)
        result.addLineBreak()

        let pattern = String.pattern(totalCount: width) {
          character("|")
          repeating(".", count: 4)
          character("╷")
          repeating(".", count: 4)
        }

        result.append(
          pattern, addsLineBreak: false,
        )
        result.addLineBreak()

    }

    return result
  }

}
