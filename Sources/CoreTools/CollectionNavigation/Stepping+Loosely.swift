//
//  ValueStepping.swift
//  DrawString
//
//  Created by Assistant on 5/3/2026.
//

import Foundation

extension Collection where Element: Comparable {
  /// Returns the next logical element after `current`.
  ///
  /// Values are compared in sorted order. This means exact and inexact inputs
  /// behave consistently, regardless of the collection's storage order.
  public func nextValueLoosely(after current: Element, wrapping: Bool = false) -> Element? {
    let sorted = sorted()
    if let nextGreater = sorted.first(where: { $0 > current }) {
      return nextGreater
    }
    return wrapping ? sorted.first : nil
  }

  /// Returns the previous logical element before `current`.
  ///
  /// Values are compared in sorted order. This means exact and inexact inputs
  /// behave consistently, regardless of the collection's storage order.
  public func previousValueLoosely(before current: Element, wrapping: Bool = false) -> Element? {
    let sorted = sorted()
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

extension Comparable {
  /// Steps this value by one position within `allowed`.
  ///
  /// The allowed values are compared in sorted order. If this value is not exactly
  /// present in `allowed`, the result falls back to the next greater value for `.up`,
  /// or the next lesser value for `.down`.
  public func steppedLoosely<C>(
    in allowed: C,
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) -> Self? where C: Collection, C.Element == Self {
    switch direction {
      case .up: return allowed.nextValueLoosely(after: self, wrapping: wrapping)
      case .down: return allowed.previousValueLoosely(before: self, wrapping: wrapping)
    }
  }
}
