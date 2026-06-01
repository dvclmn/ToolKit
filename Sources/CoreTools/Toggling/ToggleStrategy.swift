//
//  ToggleBool.swift
//  ToolKit
//
//  Created by Dave Coleman on 28/9/2025.
//

import Foundation

/// Determines how a group of boolean values should be toggled.
public enum ToggleStrategy {
  /// Toggles a uniform group, or sets a mixed group to `true`.
  case preferTrue

  /// Toggles a uniform group, or sets a mixed group to `false`.
  case preferFalse

  /// Toggles a uniform group, or sets a mixed group to the majority value.
  case followMajority

  /// Inverts each value independently.
  case invert
}

extension Collection where Element == Bool {
  
  /// Decides a single target value if the strategy calls for one.
  ///
  /// Returns `nil` when each element must be flipped individually (the `.invert` case).
  package func target(for strategy: ToggleStrategy) -> Bool? {
    guard !isEmpty else { return true }
    
    let trueCount  = filter { $0 }.count
    let falseCount = count - trueCount
    
    let allTrue  = trueCount  == count
    let allFalse = falseCount == count
    
    switch strategy {
      case .preferTrue:
        return allTrue ? false : true
        
      case .preferFalse:
        return allFalse ? true : false
        
      case .followMajority:
        if allTrue  { return false }
        if allFalse { return true  }
        return trueCount >= falseCount
        
      case .invert:
        return nil  // Signal that each item should be toggled individually.
    }
  }
}

extension MutableCollection {
  /// Toggles a boolean property on every element using `strategy`.
  public mutating func toggleAll(
    at keyPath: WritableKeyPath<Element, Bool>,
    strategy: ToggleStrategy
  ) {
    let states = self.map { $0[keyPath: keyPath] }
    
    if let target = states.target(for: strategy) {
      for i in indices {
        self[i][keyPath: keyPath] = target
      }
    } else {
      for i in indices {
        self[i][keyPath: keyPath].toggle()
      }
    }
  }
}

extension Collection {
  /// Returns copies of the elements with a boolean property toggled using `strategy`.
  func toggled(
    at keyPath: WritableKeyPath<Element, Bool>,
    strategy: ToggleStrategy
  ) -> [Element] {
    let states = self.map { $0[keyPath: keyPath] }
    return map { element in
      var copy = element
      if let target = states.target(for: strategy) {
        copy[keyPath: keyPath] = target
      } else {
        copy[keyPath: keyPath].toggle()
      }
      return copy
    }
  }
}
