//
//  IdentifiedList.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/3/2026.
//

//  A lightweight, dependency-free alternative to IdentifiedCollections' IdentifiedArray.
//  Stores elements in an Array for stable ordering and a Dictionary for O(1) id-based lookups.

import Foundation

/// An ordered list with unique IDs, backed by `Array` and `Dictionary`.
///
/// ID lookup and replacement take expected O(1) time with unshared storage.
/// Appending a new ID is amortised O(1); removal is O(n). Mutating shared
/// storage can take O(n) because the underlying collections use copy-on-write.
///
/// Elements must keep a stable ID while stored in the list. In particular,
/// externally mutating the ID of a reference-type element is unsupported.
/// Copying a list copies its structure, not objects referenced by its elements.
public struct IdentifiedList<Element: Identifiable> {
  // MARK: - Storage
  @usableFromInline
  internal var elements: [Element]

  @usableFromInline
  internal var indexByID: [Element.ID: Int]

  // MARK: - Initializers

  /// Creates an empty identified list.
  @inlinable
  public init() {
    self.elements = []
    self.indexByID = [:]
  }

  /// Creates an identified list from an array of elements.
  /// If duplicate IDs are encountered, the last value wins, retaining the
  /// position of the first occurrence. Decoding instead rejects duplicate IDs.
  @inlinable
  public init(_ elements: [Element]) {
    self.elements = []
    self.indexByID = [:]
    reserveCapacity(elements.count)
    for element in elements { updateOrAppend(element) }
  }
}

extension IdentifiedList: Equatable where Element: Equatable {}
extension IdentifiedList: Sendable where Element: Sendable, Element.ID: Sendable {}

extension IdentifiedList {

  // MARK: - Capacity
  @inlinable
  public mutating func reserveCapacity(_ n: Int) {
    elements.reserveCapacity(n)
    indexByID.reserveCapacity(n)
  }

  // MARK: - Basic operations

  /// Appends an element, replacing any existing value with the same ID in place.
  /// Prefer `updateOrAppend(_:)` when replacement is intended, to make it explicit.
  /// This spelling retains its original replacement behaviour for existing clients.
  @inlinable
  public mutating func append(_ element: Element) {
    updateOrAppend(element)
  }

  /// Replaces an existing value in place, or appends a value with a new ID.
  /// - Returns: The previous value, or `nil` if the element was newly appended.
  @discardableResult
  @inlinable
  public mutating func updateOrAppend(_ element: Element) -> Element? {
    let id = element.id
    if let index = indexByID[id] {
      let previous = elements[index]
      elements[index] = element
      return previous
    }
    elements.append(element)
    indexByID[id] = elements.endIndex - 1
    return nil
  }

  /// Removes the element at the given index.
  @discardableResult
  @inlinable
  public mutating func remove(at index: Int) -> Element {
    precondition(elements.indices.contains(index), "Index out of bounds")
    let removed = elements.remove(at: index)
    // Rebuild affected indices after removal.
    indexByID.removeValue(forKey: removed.id)
    // Only indices after `index` shift; adjust them.
    for i in index..<elements.endIndex {
      indexByID[elements[i].id] = i
    }
    return removed
  }

  /// Removes the element with the given id, if present.
  @discardableResult
  @inlinable
  public mutating func remove(id: Element.ID) -> Element? {
    guard let idx = indexByID[id] else { return nil }
    return remove(at: idx)
  }

  // MARK: - Id-based subscript

  /// Accesses the element associated with the given id for reading and writing.
  /// - If setting to `nil`, removes the element if it exists.
  /// - If setting a non-nil value:
  ///   - Replaces in-place if the id exists.
  ///   - Appends if the id does not exist.
  /// - Precondition: A non-nil value must have the requested ID. To change
  ///   identity, remove the old element and insert the replacement explicitly.
  @inlinable
  public subscript(id id: Element.ID) -> Element? {
    get {
      guard let idx = indexByID[id] else { return nil }
      return elements[idx]
    }
    set {
      if let newValue {
        precondition(newValue.id == id, "The element ID must match the subscript ID")
        updateOrAppend(newValue)
      } else {
        // Set to nil: remove if present.
        _ = remove(id: id)
      }
    }
  }
}

extension IdentifiedList: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    self.init(elements)
  }
}
