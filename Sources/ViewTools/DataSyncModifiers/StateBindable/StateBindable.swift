//
//  StateBindable.swift
//  Collection
//
//  Created by Dave Coleman on 3/2/2025.
//

import CoreTools
import SwiftUI

// Note: This is directly taken from Point-Free's implementation in
// https://github.com/pointfreeco/swift-composable-architecture
// https://github.com/pointfreeco/swift-composable-architecture/blob/20089ee985b04b1ae82e9742aa9d9c8f044700c5/Examples/CaseStudies/SwiftUICaseStudies/01-GettingStarted-FocusState.swift#L71
//
// Full credit to Point-Free, I make no claim over the logic behind this solution.
// I am made modifications to the original, but the guts is not mine.

protocol _Bindable {
  associatedtype Value
  var wrappedValue: Value { get nonmutating set }
}

struct Bind<ModelBinding: _Bindable, ViewBinding: _Bindable>: ViewModifier
where ModelBinding.Value == ViewBinding.Value, ModelBinding.Value: Equatable {

  @State private var hasAppeared = false
  @State private var debouncer: AsyncDebouncer?

  let modelValue: ModelBinding
  let viewValue: ViewBinding?
  let initialSynchronisation: InitialBindingSynchronisation
  let action: @MainActor (ModelBinding.Value) -> Void

  init(
    debounce: DebounceMode,
    modelValue: ModelBinding,
    viewValue: ViewBinding?,
    initially initialSynchronisation: InitialBindingSynchronisation,
    action: @escaping @MainActor (ModelBinding.Value) -> Void,
  ) {
    self._debouncer = debounce.createDebouncer()
    self.modelValue = modelValue
    self.viewValue = viewValue
    self.initialSynchronisation = initialSynchronisation
    self.action = action
  }

  func body(content: Content) -> some View {
    content
      .onAppear {
        guard !self.hasAppeared else { return }
        self.hasAppeared = true

        synchroniseInitially()
      }

      .onChange(of: self.modelValue.wrappedValue) { _, newValue in

        if let debouncer {
          debouncer.execute { @MainActor in
            modelDidChange(newValue)
          }
        } else {
          modelDidChange(newValue)
        }

      }

      .onChange(of: self.viewValue?.wrappedValue) { _, newValue in
        if let debouncer {
          debouncer.execute { @MainActor in
            viewDidChange(newValue)
          }
        } else {
          viewDidChange(newValue)
        }

      }
  }
}

extension Bind {
  private func synchroniseInitially() {
    switch initialSynchronisation {
      case .modelToView:
        if let debouncer {
          debouncer.execute { @MainActor in
            synchroniseModelToViewInitially()
          }
        } else {
          synchroniseModelToViewInitially()
        }

      case .viewToModel:
        if let debouncer {
          debouncer.execute { @MainActor in
            synchroniseViewToModelInitially()
          }
        } else {
          synchroniseViewToModelInitially()
        }

      case .none:
        return
    }
  }

  private func synchroniseModelToViewInitially() {
    guard let viewValue else { return }
    guard viewValue.wrappedValue != modelValue.wrappedValue else { return }
    viewValue.wrappedValue = modelValue.wrappedValue
  }

  private func synchroniseViewToModelInitially() {
    guard let viewValue else { return }
    guard modelValue.wrappedValue != viewValue.wrappedValue else { return }
    modelValue.wrappedValue = viewValue.wrappedValue
  }

  fileprivate func viewDidChange(_ newValue: ViewBinding.Value?) {
    guard let newValue else { return }
    guard self.modelValue.wrappedValue != newValue
    else { return }
    self.modelValue.wrappedValue = newValue
    self.action(newValue)
  }

  fileprivate func modelDidChange(_ newValue: ModelBinding.Value) {
    guard let viewValue else { return }
    guard viewValue.wrappedValue != newValue
    else { return }
    viewValue.wrappedValue = newValue
    self.action(newValue)
  }
}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension AccessibilityFocusState: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension AccessibilityFocusState.Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension AppStorage: _Bindable {}

extension Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension FocusedBinding: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension FocusState: _Bindable {}

@available(iOS 15, macOS 12, tvOS 15, watchOS 8, *)
extension FocusState.Binding: _Bindable {}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension SceneStorage: _Bindable {}

extension State: _Bindable {}
