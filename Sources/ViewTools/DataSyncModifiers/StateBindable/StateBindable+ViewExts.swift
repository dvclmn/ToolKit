//
//  StateBindable+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/8/2026.
//

import SwiftUI

//public func bindModel<ModelValue: _Bindable, ViewValue: _Bindable>(
//  debounce: DebounceMode,
//  _ modelValue: ModelValue,
//  to viewValue: ViewValue?,
//  initially: InitialBindingSynchronisation,
//  perform action: @escaping @MainActor (ModelValue.Value) -> Void = { _ in },
//) -> some View

extension View {

  public func bindModel<ModelValue: _Bindable, ViewValue: _Bindable>(
    debounce: DebounceMode,
    _ modelValue: ModelValue,
    to viewValue: ViewValue?,
    initially: InitialBindingSynchronisation,
    perform action: @escaping @MainActor (ModelValue.Value) -> Void = { _ in },
  ) -> some View
  where ModelValue.Value == ViewValue.Value, ModelValue.Value: Equatable {
    self.modifier(
      Bind(
        debounce: debounce,
        modelValue: modelValue,
        viewValue: viewValue,
        action: action,
      )
    )
  }
}
