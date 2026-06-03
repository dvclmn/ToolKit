//
//  String+Slice.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

/// Provides safe integer-offset slicing for string-like collections.
///
/// These methods interpret indices as zero-based integer offsets, clamp safely,
/// and never trap.
extension StringProtocol {
  
  // MARK: - Full Ranges
  /// Returns a slice for the supplied integer range.
  func slice(_ range: Range<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
  /// Returns a slice for the supplied closed integer range.
  func slice(closedRange range: ClosedRange<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
  // MARK: - Partial Ranges
  /// Returns a slice from the start up to, but not including, `upper`.
  func slice(upTo upper: Int) -> SubSequence {
    slice(start: 0, length: upper)
  }
  
  /// Returns a slice from the start through `upper`.
  func slice(through upper: Int) -> SubSequence {
    slice(start: 0, length: upper + 1)
  }

  /// Returns a slice from `lower` to the end.
  func slice(from lower: Int) -> SubSequence {
    let start = Swift.max(0, lower)
    return slice(start: start, length: count - start)
  }

  // MARK: - Core Helper
  
  private func slice(start: Int, length: Int) -> SubSequence {
    let start = Swift.max(0, start)
    let length = Swift.max(0, length)
    return prefix(start + length).suffix(length)
  }
}
