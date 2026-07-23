//
//  Binding+Toggle.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/2/2026.
//

import SwiftUI

extension OptionSet where Element == Self, Self: Hashable {
  /// Whether this option set includes `option`.
  ///
  /// Use this through a binding subscript: `$options[contains: .square]`.
  /// The option set must be `Hashable`, because Swift key paths require their
  /// subscript arguments to be hashable.
  public subscript(contains option: Self) -> Bool {
    get { contains(option) }
    set {
      if newValue {
        insert(option)
      } else {
        remove(option)
      }
    }
  }

  /// Whether this option set includes `option`, with optional exclusivity rules.
  ///
  /// Use this through a binding subscript, for example:
  /// `$options[toggling: .square, clearing: .all, preventingEmpty: true]`.
  public subscript(
    toggling option: Self,
    clearing others: Self? = nil,
    preventingEmpty preventEmpty: Bool = false,
  ) -> Bool {
    get { contains(option) }
    set {
      if newValue {
        if let others {
          subtract(others)
        }
        insert(option)
      } else {
        var proposed = self
        proposed.remove(option)

        if preventEmpty && proposed.isEmpty {
          return
        }

        self = proposed
      }
    }
  }
}

extension Dictionary where Value == Bool {
  /// The Boolean value for `key`, treating missing keys as `false`.
  ///
  /// Use this through a binding subscript: `$values[toggling: key]`.
  public subscript(toggling key: Key) -> Bool {
    get { self[key] ?? false }
    set { self[key] = newValue }
  }
}
