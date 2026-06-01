//
//  ValueStepping.swift
//  DrawString
//
//  Created by Assistant on 5/3/2026.
//

import Foundation

// MARK: - Collection helpers (Comparable fallback when `current` not found)

extension Collection where Element: Comparable {
  /// Returns the next logical element after `current`.
  ///
  /// If `current` is not present, this returns the first element that is
  /// strictly greater than `current`. See <doc:ValueStepping> for examples.
  public func nextValueLoosely(after current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    if let exact = array.firstIndex(of: current) {
      return array.nextValue(after: array[exact], wrapping: wrapping)
    }
    // Fallback: choose the smallest element greater than current
    if let nextGreater = array.sorted().first(where: { $0 > current }) {
      return nextGreater
    }
    return wrapping ? array.sorted().first : nil
  }

  /// Returns the previous logical element before `current`.
  ///
  /// If `current` is not present, this returns the greatest element that is
  /// strictly less than `current`.
  public func previousValueLoosely(before current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    if let exact = array.firstIndex(of: current) {
      return array.previousValue(before: array[exact], wrapping: wrapping)
    }
    // Fallback: choose the greatest element less than current
    let sorted = array.sorted()
    if let idx = sorted.lastIndex(where: { $0 < current }) {
      return sorted[idx]
    }
    return wrapping ? sorted.last : nil
  }

  /// Steps one position through the collection, accepting values that are not exactly present.
  public func valueLoosely(
    steppingFrom current: Element, direction: StepDirection, wrapping: Bool = false
  ) -> Element? {
    switch direction {
      case .up: return nextValueLoosely(after: current, wrapping: wrapping)
      case .down: return previousValueLoosely(before: current, wrapping: wrapping)
    }
  }
}

// MARK: - Value-centric helpers

extension Comparable {
  /// Steps this value by one position within `allowed`.
  ///
  /// If this value is not exactly present in `allowed`, the result falls back to
  /// the next greater value for `.up`, or the next lesser value for `.down`.
  public func steppedLoosely(
    in allowed: [Self],
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) -> Self? {
    switch direction {
      case .up: return allowed.nextValueLoosely(after: self, wrapping: wrapping)
      case .down: return allowed.previousValueLoosely(before: self, wrapping: wrapping)
    }
  }
}
