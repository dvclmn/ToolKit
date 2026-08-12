//
//  StateBindable+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/8/2026.
//

import SwiftUI

extension View {

  public func bindModel<HandlerValue: _Bindable, ViewValue: _Bindable>(
    debounce: DebounceMode,
    _ handlerValue: HandlerValue,
    to viewValue: ViewValue?,
    perform action: @escaping @MainActor (HandlerValue.Value) -> Void = { _ in },
  ) -> some View
  where HandlerValue.Value == ViewValue.Value, HandlerValue.Value: Equatable {
    self.modifier(
      Bind(
        debounce: debounce,
        handlerValue: handlerValue,
        viewValue: viewValue,
        action: action,
      )
    )
  }
}
