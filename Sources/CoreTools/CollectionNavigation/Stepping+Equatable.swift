//
//  Stepping+Equatable.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/3/2026.
//

import Foundation

extension Collection where Element: Equatable {
  
  /// Returns the next element after `current` within this collection, or `nil` if `current` is not found
  /// and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - wrapping: If true, stepping beyond the end wraps to the first element.
  /// - Returns: The next element, or `nil`.
  public func nextValue(after current: Element, wrapping: Bool = false) -> Element? {
    Array(self).nextElement(after: current, wrapping: wrapping)
  }

  /// Returns the previous element before `current` within this collection, or `nil` if `current` is not found
  /// and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - wrapping: If true, stepping before the start wraps to the last element.
  /// - Returns: The previous element, or `nil`.
  public func previousValue(before current: Element, wrapping: Bool = false) -> Element? {
    Array(self).previousElement(before: current, wrapping: wrapping)
  }

  /// Returns the element stepping `steps` positions from `current` within this collection.
  /// Positive `steps` step forward; negative `steps` step backward.
  /// Returns `nil` if `current` is not found and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - steps: Number of steps to move; positive to step forward, negative to step backward.
  ///   - wrapping: If true, indexes wrap around the collection bounds. If false, stepping beyond
  ///     either bound returns `nil`.
  public func value(steppingFrom current: Element, by steps: Int, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    guard let idx = array.firstIndex(of: current) else { return nil }
    let count = array.count
    guard count > 0 else { return nil }
    guard steps != 0 else { return current }

    let base = array.distance(from: array.startIndex, to: idx)

    if wrapping {
      let offset = steps % count
      let wrappedIndex = (base + offset + count) % count
      return array[wrappedIndex]
    }

    guard steps >= -base, steps <= (count - 1 - base) else { return nil }
    return array[base + steps]
  }
}

extension Equatable {
  /// Returns this value moved one position within `allowed`.
  ///
  /// This is exact, position-based navigation: `allowed` keeps its existing order,
  /// and `nil` is returned when this value is not present.
  @_spi(Internal) public func stepped<C>(
    in allowed: C,
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) -> Self? where C: BidirectionalCollection, C.Element == Self {
    switch direction {
      case .up: return allowed.nextElement(after: self, wrapping: wrapping)
      case .down: return allowed.previousElement(before: self, wrapping: wrapping)
    }
  }
}
