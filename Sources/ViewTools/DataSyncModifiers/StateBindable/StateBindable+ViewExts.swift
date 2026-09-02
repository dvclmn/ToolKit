//
//  StateBindable+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/8/2026.
//

import SwiftUI
import CoreTools

extension View {

  /// Keeps a model value and view-local value synchronised.
  ///
  /// On the modified view's first appearance, `initially` selects whether the
  /// model writes to the view, the view writes to the model, or neither value
  /// is copied.
  ///
  /// After initial appearance, changes to either value are copied to the other.
  /// Equal values are ignored to prevent echo writes.
  ///
  /// - Note: Initial synchronisation uses the supplied debounce behaviour.
  /// - Note: `perform` is called for subsequent effective changes, but not for
  ///   the initial synchronisation.
  /// - Parameters:
  ///   - debounce: Debounce behaviour applied to synchronisation writes.
  ///   - modelValue: The model value to synchronise.
  ///   - viewValue: The optional view-local value to synchronise.
  ///   - initially: The direction of the first synchronisation, if any.
  ///   - action: An action called after a subsequent value is copied.
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
        initially: initially,
        action: action,
      )
    )
  }
}
