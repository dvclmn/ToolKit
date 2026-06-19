//
//  NSTextContentManager.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/12/2025.
//

#if canImport(AppKit)
import AppKit

extension NSTextContentManager {
  /// Converts a TextKit 2 text range into an `NSRange`.
  public func range(for textRange: NSTextRange) -> NSRange? {
    let location = offset(from: documentRange.location, to: textRange.location)
    let length = offset(from: textRange.location, to: textRange.endLocation)
    if location == NSNotFound || length == NSNotFound { return nil }
    return NSRange(location: location, length: length)
  }

  /// Converts an `NSRange` into a TextKit 2 text range.
  public func textRange(for range: NSRange) -> NSTextRange? {
    guard
      let textRangeLocation = location(documentRange.location, offsetBy: range.location),
      let endLocation = location(textRangeLocation, offsetBy: range.length)
    else { return nil }
    return NSTextRange(location: textRangeLocation, end: endLocation)
  }
}
#endif
