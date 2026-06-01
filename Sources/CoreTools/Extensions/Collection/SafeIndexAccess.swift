//
//  SafeIndexAccess.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation

extension MutableCollection {

  /// Safely reads or writes an element when `index` is valid.
  public subscript(safe index: Index) -> Element? {
    get { indices.contains(index) ? self[index] : nil }
    set {
      guard let newValue, indices.contains(index) else { return }
      self[index] = newValue
    }
  }
}

extension Collection {

  /// Safely returns a subsequence when `bounds` are fully contained in the collection.
  public subscript(safe bounds: Range<Index>) -> SubSequence? {
    guard
      bounds.lowerBound >= startIndex,
      bounds.upperBound <= endIndex
    else {
      return nil
    }

    return self[bounds]
  }

  /// Safely returns a subsequence when `bounds` are fully contained in the collection.
  public subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
    guard
      bounds.lowerBound >= startIndex,
      bounds.upperBound < endIndex
    else {
      return nil
    }

    return self[bounds]
  }

  /// Returns whether the collection contains an element at integer `offset`.
  public func hasIndex(_ offset: Int) -> Bool {
    let startIndex = self.startIndex
    let endIndex = self.endIndex
    guard let index = self.index(startIndex, offsetBy: offset, limitedBy: endIndex) else {
      return false
    }
    return index < endIndex
  }

}
