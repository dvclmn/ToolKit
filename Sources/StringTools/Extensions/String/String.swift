//
//  String.swift
//  StringTools
//
//  Created by Dave Coleman on 9/10/2024.
//

import Foundation

// Source - https://stackoverflow.com/a
// Posted by Leo Dabus, modified by community. See post 'Timeline' for change history
// Retrieved 2025-11-21, License - CC BY-SA 4.0
extension StringProtocol {

  /// Returns the element at a zero-based offset, or `nil` when the offset is
  /// outside the collection.
  public func element(at offset: Int) -> Element? {
    guard offset >= 0 else { return nil }
    return index(startIndex, offsetBy: offset, limitedBy: endIndex)
      .map { self[$0] }
  }

  /// Returns the element at a zero-based offset, clamping out-of-bounds offsets
  /// to the nearest valid position.
  public func elementClamped(at offset: Int) -> Element? {
    guard !isEmpty else { return nil }
    let clamped = Swift.max(0, Swift.min(offset, count - 1))
    let idx = index(startIndex, offsetBy: clamped)
    return self[idx]
  }

}

extension String {

  /// Returns the string with its first character uppercased.
  public var capitalizedFirstLetter: String {
    return prefix(1).uppercased() + dropFirst()
  }

  /// Pads the string with spaces on the right to at least the given width.
  public func padded(
    to width: Int,
    using padString: String = " ",
  ) -> String {
    if count >= width { return self }
    return self + String(repeating: padString, count: width - count)
  }

  /// Combines two strings with a separator.
  public func combining(
    with other: String,
    separator: String = ", ",
  ) -> String {
    self + separator + other
  }

  /// The number of letter-based words in the string.
  public var wordCount: Int {
    let words = self.split { !$0.isLetter }
    return words.count
  }

  /// Converts a string-index range to an `NSRange`.
  public func nsRange(from range: Range<String.Index>) -> NSRange? {
    guard range.lowerBound >= startIndex, range.upperBound <= endIndex else {
      return nil
    }
    return NSRange(range, in: self)
  }

  /// Converts an `NSRange` into a string-index range.
  public func range(from nsRange: NSRange) -> Range<String.Index>? {
    return Range(nsRange, in: self)
  }

  /// Returns the substring covered by an `NSRange`.
  public func substring(in nsRange: NSRange) -> Substring? {
    guard let range = self.range(from: nsRange) else { return nil }
    return self[range]
  }

}

extension Array where Element == String {
  
  /// Joins the strings using `separator`.
  public func joined(_ separator: String) -> String {
    self.joined(separator: separator)
  }
  
  /// Joins the strings with newline separators.
  public func joinedLines() -> String {
    self.joined(separator: "\n")
  }
}
extension Array where Element == String? {
  /// Drops `nil` values, then joins the remaining strings.
  public func joinedCompact(_ separator: String = "") -> String {
    self.compactMap(\.self).joined(separator: separator)
  }
}

extension String {

  /// Quote mark styles used by ``String/withQuotes(_:)``.
  public enum QuotesType: String {
    case single = "'"
    case double = "\""
  }

  /// Returns the string surrounded by double quotes.
  public var withQuotes: String {
    self.withQuotes(.double)
  }

  /// Returns the string surrounded by the requested quote mark.
  public func withQuotes(_ type: QuotesType = .double) -> String {
    return "\(type.rawValue)\(self)\(type.rawValue)"
  }
}

extension UUID {
  /// Returns a shortened representation of the UUID string.
  public func truncated(
    to maxLength: Int = 8,
    style: TruncationStyle = .middle,
  ) -> String {
    self.uuidString.truncate(to: maxLength, style: style)
  }
}
