//
//  NSRange.swift
//  StringTools
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension NSRange {
  /// A zero-location, zero-length range.
  public static let zero = NSRange(location: 0, length: 0)
  
  /// A zero-length range whose location is `NSNotFound`.
  public static let notFound = NSRange(location: NSNotFound, length: 0)
  
  /// The location immediately after the range.
  public var max: Int { NSMaxRange(self) }
}
