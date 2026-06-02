//
//  Binding.swift
//  Collection
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

extension Binding where Value: Sendable {
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

extension Binding where Value == Bool {
  public var reversed: Binding<Bool> {
    return .init(
      get: { !self.wrappedValue },
      set: { self.wrappedValue = !$0 },
    )
  }
}
