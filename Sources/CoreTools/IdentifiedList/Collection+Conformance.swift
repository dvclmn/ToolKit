//
//  Collection+Conformance.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

extension IdentifiedList: RandomAccessCollection, MutableCollection {
  public typealias Index = Int

  @inlinable public var startIndex: Int { elements.startIndex }
  @inlinable public var endIndex: Int { elements.endIndex }
  @inlinable public func index(after i: Int) -> Int { elements.index(after: i) }
  @inlinable public func index(before i: Int) -> Int { elements.index(before: i) }

  /// Replaces the element at a position without introducing duplicate IDs.
  /// If the new ID already occupies another position, the displaced element
  /// moves to that position. This also supports collection permutation algorithms.
  /// A previously absent ID replaces the old ID outright.
  @inlinable public subscript(position: Int) -> Element {
    get { elements[position] }
    set {
      let old = elements[position]
      if old.id != newValue.id {
        if let existingIndex = indexByID[newValue.id] {
          elements[existingIndex] = old
          indexByID[old.id] = existingIndex
        } else {
          indexByID.removeValue(forKey: old.id)
        }
      }
      elements[position] = newValue
      indexByID[newValue.id] = position
    }
  }

  /// Exchanges two elements and updates their lookup positions.
  @inlinable
  public mutating func swapAt(_ i: Int, _ j: Int) {
    elements.swapAt(i, j)
    indexByID[elements[i].id] = i
    indexByID[elements[j].id] = j
  }

  /// Sorts the elements, restoring ID lookup even if the predicate throws.
  @inlinable
  public mutating func sort(
    by areInIncreasingOrder: (Element, Element) throws -> Bool
  ) rethrows {
    defer { rebuildIndices() }
    try elements.sort(by: areInIncreasingOrder)
  }

  /// Partitions the elements, restoring ID lookup even if the predicate throws.
  @inlinable
  public mutating func partition(
    by belongsInSecondPartition: (Element) throws -> Bool
  ) rethrows -> Int {
    defer { rebuildIndices() }
    return try elements.partition(by: belongsInSecondPartition)
  }

  @usableFromInline
  internal mutating func rebuildIndices() {
    indexByID.removeAll(keepingCapacity: true)
    for index in elements.indices {
      indexByID[elements[index].id] = index
    }
  }
}

extension IdentifiedList where Element: Comparable {
  @inlinable
  public mutating func sort() {
    sort(by: <)
  }
}
