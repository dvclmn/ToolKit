//
//  NSString.swift
//  StringTools
//
//  Created by Dave Coleman on 14/2/2025.
//

#if os(macOS)
import AppKit

public extension NSString {
  /// Converts a Swift string-index range into an `NSRange` for this string.
  func range(from range: Range<String.Index>) -> NSRange {
    let utf16Start = range.lowerBound.utf16Offset(in: self as String)
    let utf16End = range.upperBound.utf16Offset(in: self as String)
    return NSRange(location: utf16Start, length: utf16End - utf16Start)
  }
}
#endif
