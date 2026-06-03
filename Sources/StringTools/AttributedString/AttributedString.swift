//
//  AttributedString.swift
//  StringTools
//
//  Created by Dave Coleman on 31/8/2024.
//

import Foundation

extension AttributedString {
  
  /// Returns the attributed-string index at a character offset.
  public func index(at offset: Int) -> AttributedString.Index? {
    guard offset >= 0 && offset <= characters.count else {
      return nil
    }
    return index(startIndex, offsetByCharacters: offset)
  }

  /// Splits the attributed string's characters into line substrings.
  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    toString.lines(omissionStrategy: omissionStrategy)
  }

  /// Splits the attributed string's characters into `String` lines.
  public func stringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [String] {
    toString.stringLines(omissionStrategy: omissionStrategy)
  }

  /// Appends text, optionally followed by a line break.
  public mutating func append(
    _ string: String,
    addsLineBreak: Bool,
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(string)\n" : "\(string)")
  }

  /// Appends a character, optionally followed by a line break.
  public mutating func append(
    _ character: Character,
    addsLineBreak: Bool,
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(character)\n" : "\(character)")
  }

  /// Appends a newline character.
  public mutating func addLineBreak() {
    self.characters.append("\n")
  }

}

extension Array where Element == AttributedString {
  /// Joins attributed strings with an attributed separator.
  public func joined(_ separator: String = "") -> AttributedString {
    guard !isEmpty else { return AttributedString() }

    // Pre-create separator once to avoid repeated initialisation.
    let separatorAttr = AttributedString(separator)

    // Use reduce(into:) for in-place mutation.
    return dropFirst().reduce(into: self[0]) { result, element in
      result.append(separatorAttr)
      result.append(element)
    }
  }
}

extension AttributedString {
  /// Returns a copy with `string` appended.
  public func appending(_ string: String) -> AttributedString {
    var copy = self
    copy.append(string.toAttributed)
    return copy
  }
}

extension String {
  /// Returns an attributed string with `attributed` appended after this string.
  public func appending(_ attributed: AttributedString) -> AttributedString {
    var attr = self.toAttributed
    attr.append(attributed)
    return attr

  }
}
