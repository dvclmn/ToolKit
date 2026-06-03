//
//  Range.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/5/2026.
//

import Foundation

extension CountableClosedRange where Bound == Int {

  /// Converts an integer character range into an `AttributedString` range.
  public func attributedRange(for attrString: AttributedString) -> Range<AttributedString.Index>? {
    let start = attrString.index(at: self.lowerBound)
    let end = attrString.index(at: self.upperBound + 1)

    guard let start, let end else { return nil }
    return start..<end
  }
}

extension Range where Bound == String.Index {

  /// Converts the string-index range to an `NSRange` in the supplied string.
  public func toNSRange(in string: String) -> NSRange? {
    string.nsRange(from: self)
  }

  /// Converts the string-index range to an `AttributedString` range.
  public func getAttributedRange(
    in attrString: AttributedString
  ) -> Range<AttributedString.Index>? {

    // Convert String.Index range to AttributedString.Index range.
    let startIndex = AttributedString.Index(self.lowerBound, within: attrString)
    let endIndex = AttributedString.Index(self.upperBound, within: attrString)

    // Check if both indices are valid.
    guard let start = startIndex, let end = endIndex else {
      print("Invalid range")
      return nil
    }

    // Create the AttributedString range.
    let attributedStringRange: Range<AttributedString.Index> = start..<end

    return attributedStringRange
  }
}

extension Range {

  /// Creates a range from a collection's default indices.
  ///
  /// This is useful when a regex capture exposes its bounds through
  /// `match.output.1.indices`.
  public init<Collection: Swift.Collection>(_ indices: DefaultIndices<Collection>)
  where Collection.Index == Bound {
    self = indices.startIndex..<indices.endIndex
  }
}

extension Array where Element == Range<String.Index> {
  /// Converts each string-index range to an `NSRange`, dropping invalid ranges.
  public func toNSRanges(in string: String) -> [NSRange] {
    self.compactMap { stringRange in
      guard let range = stringRange.toNSRange(in: string) else {
        print("Could not convert to NSRange")
        return nil
      }
      return range

    }
  }
}

extension Collection {
  /// The complete index range of the collection.
  ///
  /// This is useful for regex capture groups, where
  /// `match.output.1.indexRange` can be converted into a `Range`.
  public var indexRange: Range<Index> {
    startIndex..<endIndex
  }
}

extension Range where Bound: BinaryFloatingPoint {
  /// The numeric distance between the range's lower and upper bounds.
  public var length: Self.Bound {
    upperBound - lowerBound
  }
}
