//
//  Set.swift
//  Collection
//
//  Created by Dave Coleman on 26/9/2024.
//

import Foundation

// NOTE:
// Set conforms to both Collection and Sequence

extension Set {
  public var toArray: [Element] {
    Array(self)
  }
}

extension Set {
  /// Toggles membership of `element` in the set.
  /// - Returns: `true` if the element is a member after the toggle, `false` if it was removed.
  @discardableResult
  public mutating func toggleMembership(of element: Element) -> Bool {
    guard self.contains(element) else {
      self.insert(element)
      return true
    }
    self.remove(element)
    return false
  }

  /// Sets membership of `element` in the set to match `isMember`.
  /// - Parameters:
  ///   - element: The element whose membership to update.
  ///   - isMember: When `true`, the element will be present in the set; when `false`, it will be removed.
  /// - Returns: `true` if the element is a member after the update, `false` otherwise.
  @discardableResult
  public mutating func setMembership(of element: Element, to isMember: Bool) -> Bool {
    guard isMember else {
      self.remove(element)
      return false
    }
    self.insert(element)
    return true
  }
}
