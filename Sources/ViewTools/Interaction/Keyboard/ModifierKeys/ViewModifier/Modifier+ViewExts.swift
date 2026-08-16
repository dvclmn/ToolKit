//
//  Modifier+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/8/2026.
//

import SwiftUI

extension View {
  // A convenience, to only add the modifiers to the Environment,
  // without requiring caller to provide an action closure
  public func readModifierKeys(_ mask: EventModifiers = .all) -> some View {
    self.modifier(
      ModifierKeysModifier(
        keysToWatch: mask,
        modifiersDidChange: nil,
      )
    )
  }

  /// Ensures that this view's subtree observes every modifier key in `mask`.
  ///
  /// If an ancestor already observes the complete mask, this modifier reuses
  /// that environment state. Otherwise, it establishes a local reader while
  /// preserving any additional keys observed by the ancestor.
  public func ensureModifierKeys(_ mask: EventModifiers = .all) -> some View {
    self.modifier(
      EnsureModifierKeysModifier(requiredMask: mask)
    )
  }
  
  /// Note: This modifier also adds modifier keys to the Environment
  public func modifierKeys(
    _ mask: EventModifiers = .all,
    onChange perform: @escaping (Modifiers) -> Void,
  ) -> some View {
    self.modifier(
      ModifierKeysModifier(
        keysToWatch: mask,
        modifiersDidChange: perform,
      )
    )
  }
  
//  public func modifierKeys(
//    _ mask: EventModifiers = .all,
//    onChange perform: @escaping (EventModifiers) -> Void,
//  ) -> some View {
//    self.modifier(
//      ModifierKeysModifier(
//        keysToWatch: mask,
//        onModifiersChange: nil,
//        onEventModifiersChange: perform,
//      )
//    )
//  }
}

private struct EnsureModifierKeysModifier: ViewModifier {
  @Environment(\.modifierKeyState) private var inheritedState

  let requiredMask: EventModifiers

  @ViewBuilder
  func body(content: Content) -> some View {
    if inheritedState?.observedMask.isSuperset(of: requiredMask) == true {
      content
    } else {
      content.modifier(
        ModifierKeysModifier(
          keysToWatch: effectiveMask,
          modifiersDidChange: nil,
        )
      )
    }
  }

  private var effectiveMask: EventModifiers {
    inheritedState?.observedMask.union(requiredMask) ?? requiredMask
  }
}
