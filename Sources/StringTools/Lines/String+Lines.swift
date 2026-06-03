//
//  SubString.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/9/2025.
//

import Foundation

extension Array where Element == String {
  /// Returns a copy of the array with `element` prepended to the first string.
  public func preprendToFirstLine(_ element: Element) -> [Element] {
    var result: [Element] = self
    result[0] = element + "\(result[0])"
    return result
  }

  /// Returns a copy of the array with `element` appended to the last string.
  public func appendToLastLine(_ element: Element) -> [Element] {
    var result: [Element] = self
    result[result.endIndex - 1] = "\(result[result.endIndex - 1])\(element)"
    return result
  }
}

extension String {

  /// Whether the string currently ends with an empty line.
  public var isLastLineEmpty: Bool {
    lines().last?.isEmpty == true
  }

  /// Splits the string into line substrings.
  public func lines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    omissionStrategy.split(self, whereSeparator: \.isNewline)
  }

  /// Splits the string into lines, then returns each line as an array of characters.
  public func characterLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [[Substring.Element]] {
    lines(omissionStrategy: omissionStrategy).map(Array.init)
  }

  /// Splits the string into lines and converts each line to `String`.
  public func stringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [String] {
    lines(omissionStrategy: omissionStrategy).map(String.init)
  }

  /// Splits the string into components using a single-character separator.
  public func components(
    separatedBy separator: Character,
    omissionStrategy: OmissionStrategy = .doNotOmit
  ) -> [String] {
    omissionStrategy
      .split(self, separator: separator)
      .map(String.init)
  }

  @available(*, deprecated, renamed: "lines(omissionStrategy:)")
  public func substringLines(omissionStrategy: OmissionStrategy = .doNotOmit) -> [Substring] {
    lines(omissionStrategy: omissionStrategy)
  }

  /// The first line of the string, or an empty string when the string is empty.
  public var firstLine: String {
    let first = split(separator: "\n").first ?? ""
    return String(first)
  }

  /// Appends a newline character (`\n`) to the end of the string if it does
  /// not already end with one. Otherwise returns the original string unchanged.
  public var addingNewLine: String {
    guard let last, !last.isNewline else {
      return self
    }
    return self + "\n"
  }

  /// The character count of the longest line.
  public var longestLineLength: Int {
    lines(omissionStrategy: .doNotOmit)
      .map { $0.count }.max() ?? 1
  }

  /// Returns the string with each line prefixed by the requested indentation.
  public func linesIndented(
    level: Int = 1,
    using indentString: String = "\t"
  ) -> String {
    let indent = String(repeating: indentString, count: level)
    let indentedLines = lines().map { indent + $0 }
    return indentedLines.joined("\n")
  }

  /// Inserts line breaks at a fixed character interval.
  public func insertingLineBreak(every characters: Int) -> String {
    guard characters > 0 else { return self }

    var lines: [String] = []
    var currentIndex = startIndex

    while currentIndex < endIndex {
      let remainingDistance = distance(from: currentIndex, to: endIndex)
      let chunkSize = min(characters, remainingDistance)

      let nextIndex = index(currentIndex, offsetBy: chunkSize)
      let line = String(self[currentIndex..<nextIndex])
      lines.append(line)

      currentIndex = nextIndex
    }

    return lines.joined("\n")
  }

}
