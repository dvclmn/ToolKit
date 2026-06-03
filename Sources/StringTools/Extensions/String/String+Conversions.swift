//
//  String+Conversions.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/11/2025.
//

import Foundation

extension String {

  /// Attempts to create a `URL` from the string.
  public var toURL: URL? {
    return URL(string: self)
  }

  /// Converts the string to an `AttributedString`.
  public var toAttributed: AttributedString {
    return AttributedString(self)
  }

  /// Returns `String(describing:)` for the string.
  public var toDescribing: String {
    return String(describing: self)
  }

  /// The characters in the string.
  public var toCharacters: [Character] { Array(self) }

  /// Converts camel-case text to snake-case text.
  public var camelCaseToSnakeCase: String {
    var result = ""
    for (index, ch) in self.enumerated() {
      if ch.isUppercase {
        if index > 0 { result.append("_") }
        result.append(ch.lowercased())
      } else {
        result.append(ch)
      }
    }
    return result
  }

  /// Converts camel-case text to capitalised words.
  public var camelCaseToWords: String {
    // Handle both upper camel case (PatternType) and lower camel case (patternType).
    let pattern = "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])"
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: self.count)

    let spaced =
      regex?
      .stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " ")
      .capitalized ?? self

    return spaced
  }

}
