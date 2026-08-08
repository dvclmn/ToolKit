//
//  Modifiers+Mapping.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/6/2026.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

struct ModifierKeyMapping {
  let modifiers: Modifiers?
  let eventModifiers: EventModifiers

  #if canImport(AppKit)
  let nsEventModifierFlags: NSEvent.ModifierFlags
  #endif
}

enum ModifierKeyBridge {
  static let functionEventModifiers = EventModifiers(rawValue: 1 << 6)

  #if canImport(AppKit)
  static let mappings: [ModifierKeyMapping] = [
    .init(
      modifiers: .shift,
      eventModifiers: .shift,
      nsEventModifierFlags: .shift
    ),
    .init(
      modifiers: .option,
      eventModifiers: .option,
      nsEventModifierFlags: .option
    ),
    .init(
      modifiers: .command,
      eventModifiers: .command,
      nsEventModifierFlags: .command
    ),
    .init(
      modifiers: .control,
      eventModifiers: .control,
      nsEventModifierFlags: .control
    ),
    .init(
      modifiers: .capsLock,
      eventModifiers: .capsLock,
      nsEventModifierFlags: .capsLock
    ),
    .init(
      modifiers: .numericPad,
      eventModifiers: .numericPad,
      nsEventModifierFlags: .numericPad
    ),
    .init(
      modifiers: nil,
      eventModifiers: functionEventModifiers,
      nsEventModifierFlags: .function
    ),
  ]
  #else
  private static let mappings: [ModifierKeyMapping] = [
    .init(modifiers: .shift, eventModifiers: .shift),
    .init(modifiers: .option, eventModifiers: .option),
    .init(modifiers: .command, eventModifiers: .command),
    .init(modifiers: .control, eventModifiers: .control),
    .init(modifiers: .capsLock, eventModifiers: .capsLock),
    .init(modifiers: .numericPad, eventModifiers: .numericPad),
  ]
  #endif

  static func modifiers(where sourceContains: (ModifierKeyMapping) -> Bool) -> Modifiers {
    mappings.reduce(into: []) { result, mapping in
      guard sourceContains(mapping), let modifiers = mapping.modifiers else { return }
      result.insert(modifiers)
    }
  }

  static func eventModifiers(where sourceContains: (ModifierKeyMapping) -> Bool) -> EventModifiers {
    mappings.reduce(into: []) { result, mapping in
      guard sourceContains(mapping) else { return }
      result.insert(mapping.eventModifiers)
    }
  }

  #if canImport(AppKit)
  static func nsEventModifierFlags(
    where sourceContains: (ModifierKeyMapping) -> Bool
  ) -> NSEvent.ModifierFlags {
    mappings.reduce(into: []) { result, mapping in
      guard sourceContains(mapping) else { return }
      result.insert(mapping.nsEventModifierFlags)
    }
  }
  #endif
}
