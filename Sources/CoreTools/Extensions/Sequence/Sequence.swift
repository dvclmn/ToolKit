//
//  Sequence.swift
//  Collection
//
//  Created by Dave Coleman on 25/9/2024.
//

import Foundation

extension Sequence where Element: Identifiable {

  /// Returns the element with the greatest value at `dateKeyPath`.
  public func mostRecent<T: Comparable>(
    by dateKeyPath: KeyPath<Element, T>
  ) -> Element? {

    self.max(by: { $0[keyPath: dateKeyPath] < $1[keyPath: dateKeyPath] })

  }
}
extension Sequence where Element: Hashable {
  /// Creates a dictionary from the elements in the sequence with the same default value.
  public func dictionaryWithDefault<T>(of defaultValue: T) -> [Element: T] {
    Dictionary(uniqueKeysWithValues: self.map { ($0, defaultValue) })
  }
}

extension Sequence where Element: Equatable {
  /// Returns the sequence's unique elements while preserving first-seen order.
  public func uniquedPreservingOrder() -> [Element] {
    var seen: [Element] = []
    for element in self where !seen.contains(element) {
      seen.append(element)
    }
    return seen
  }
}

extension Sequence {

  /// Builds a delimited summary by sorting elements and reading a key path from each one.
  public func summarise<T: Comparable>(
    key: PartialKeyPath<Element>,
    sortedBy keyPath: KeyPath<Element, T>,
    delimiter: Character? = ",",
  ) -> String {
    return
      self
      .sorted(by: keyPath)
      .map { String(describing: $0[keyPath: key]) }
      .enumerated()
      .reduce(into: "") { (result, element) in
        let (index, value) = element
        if index > 0 {
          if let delimiter {
            result += "\(delimiter) "
          }
        }
        result += value
      }
  }

  /// Sorts the sequence by the value at `keyPath`.
  public func sorted<T: Comparable>(
    by keyPath: KeyPath<Element, T>,
    using comparator: (T, T) -> Bool = (<),
  ) -> [Element] {
    sorted { a, b in
      comparator(a[keyPath: keyPath], b[keyPath: keyPath])
    }
  }

}
