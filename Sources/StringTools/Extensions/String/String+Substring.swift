//
//  String+Substring.swift
//  ToolKit
//
//  Created by Dave Coleman on 20/12/2025.
//

#if canImport(AppKit)
import AppKit

extension Substring {
  /// Converts the substring's range into an `NSRange` relative to its base string.
  ///
  /// Use this with APIs like `NSRegularExpression`, `NSAttributedString`, and
  /// `NSTextView` that expect ranges based on UTF-16 code units.
  public var nsRangeUsingSubstringBase: NSRange {
    return NSRange(self.startIndex..<self.endIndex, in: self.base)
  }

  /// Converts the substring's range into an `NSRange` relative to `text`.
  public func nsRange(in text: String) -> NSRange {
    return NSRange(self.startIndex..<self.endIndex, in: text)
  }

}

extension Array where Element == Substring {
  /// The total character count across all substrings.
  public var characterCount: Int {
    reduce(0) { accumulatingResult, nextValue in
      accumulatingResult + nextValue.count
    }
  }
}
#endif
