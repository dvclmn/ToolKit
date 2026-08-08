//
//  Modifier+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/8/2026.
//

import SwiftUI

extension View {
  public func readModifierKeys(_ mask: EventModifiers = .all) -> some View {
    self.modifier(
      ModifierKeysModifier(
        keysToWatch: mask,
        onModifiersChange: nil,
        onEventModifiersChange: nil,
      )
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
        onModifiersChange: perform,
        onEventModifiersChange: nil,
      )
    )
  }
  
  public func modifierKeys(
    _ mask: EventModifiers = .all,
    onChange perform: @escaping (EventModifiers) -> Void,
  ) -> some View {
    self.modifier(
      ModifierKeysModifier(
        keysToWatch: mask,
        onModifiersChange: nil,
        onEventModifiersChange: perform,
      )
    )
  }
}
