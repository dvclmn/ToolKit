//
//  String+LinesCols.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/11/2025.
//

#if canImport(AppKit)
import AppKit
import Foundation

extension String {

  /// Counts the one-based line and column at the start of an `NSRange`.
  public func countLinesAndColumns(in range: NSRange) -> (line: Int, column: Int) {
    self.countLinesAndColumns(upTo: range.location)
  }

  /// Counts the one-based line and column up to a safe character offset.
  public func countLinesAndColumns(
    upTo targetLocation: Int,
  ) -> (line: Int, column: Int) {
    var lineNumber = 1
    var columnNumber = 1
    var currentIndex = 0

    let safeLimit = min(targetLocation, self.count)

    while currentIndex < safeLimit {
      if self.isNewLine(at: currentIndex) {
        lineNumber += 1
        columnNumber = 1
      } else {
        columnNumber += 1
      }
      currentIndex += 1
    }

    return (lineNumber, columnNumber)
  }

  private func isNewLine(
    at offset: Int
  ) -> Bool {
    self.element(at: offset) == "\n"
  }

  /// Counts newline-delimited lines inside an `NSRange`.
  public func countNewlines(in range: NSRange) -> Int {
    self.countNewlines(
      from: range.location,
      to: range.location + range.length
    )
  }

  /// Counts newline-delimited lines between two character offsets.
  public func countNewlines(
    from start: Int,
    to end: Int
  ) -> Int {
    var count = 1
    let safeEnd = min(end, self.count)

    var currentIndex = max(start, 0)
    while currentIndex < safeEnd {
      if self.isNewLine(at: currentIndex) {
        count += 1
      }
      currentIndex += 1
    }
    return count
  }
}
#endif
