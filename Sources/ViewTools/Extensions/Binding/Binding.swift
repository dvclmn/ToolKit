//
//  Binding.swift
//  Collection
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

extension Binding where Value: Sendable {
  /// Presents a nonoptional binding as optional, ignoring writes of `nil`.
  ///
  /// This remains closure-backed because an arbitrary `Value` cannot expose a
  /// writable optional member for `Binding`'s dynamic-member projection.
  public var toOptionalBinding: Binding<Value?> {
    Binding<Value?>(
      get: { wrappedValue },
      set: {
        guard let value = $0 else { return }
        wrappedValue = value
      },
    )
  }
}

extension Bool {
  /// The logical inverse of this value.
  ///
  /// `Binding` projects this writable property through dynamic-member lookup,
  /// so `$isEnabled.reversed` retains SwiftUI's key-path binding identity.
  public var reversed: Self {
    get { !self }
    set { self = !newValue }
  }
}
