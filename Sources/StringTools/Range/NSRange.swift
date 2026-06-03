//
//  NSRange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension NSRange {
  public static let zero = NSRange(location: 0, length: 0)
  public static let notFound = NSRange(location: NSNotFound, length: 0)
  public var max: Int { NSMaxRange(self) }
}
