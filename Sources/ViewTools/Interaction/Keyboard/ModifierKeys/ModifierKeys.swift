//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// A representation of Modifiers that doesn't rely
/// on / can bridge between SwiftUI / AppKit
public struct Modifiers: OptionSet, Sendable, Hashable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let shift = Self(rawValue: 1 << 0)
  public static let option = Self(rawValue: 1 << 1)
  public static let command = Self(rawValue: 1 << 2)
  public static let control = Self(rawValue: 1 << 3)
  public static let capsLock = Self(rawValue: 1 << 4)
  public static let numericPad = Self(rawValue: 1 << 5)

  public static let all: Self = [
    .shift, .option, .command, .control, .capsLock, .numericPad,
  ]
}

private struct ModifierKeyMapping {
  let modifiers: Modifiers?
  let eventModifiers: EventModifiers

  #if canImport(AppKit)
  let nsEventModifierFlags: NSEvent.ModifierFlags
  #endif
}

private enum ModifierKeyBridge {
  private static let functionEventModifiers = EventModifiers(rawValue: 1 << 6)

  #if canImport(AppKit)
  private static let mappings: [ModifierKeyMapping] = [
    .init(modifiers: .shift, eventModifiers: .shift, nsEventModifierFlags: .shift),
    .init(modifiers: .option, eventModifiers: .option, nsEventModifierFlags: .option),
    .init(modifiers: .command, eventModifiers: .command, nsEventModifierFlags: .command),
    .init(modifiers: .control, eventModifiers: .control, nsEventModifierFlags: .control),
    .init(modifiers: .capsLock, eventModifiers: .capsLock, nsEventModifierFlags: .capsLock),
    .init(modifiers: .numericPad, eventModifiers: .numericPad, nsEventModifierFlags: .numericPad),
    .init(modifiers: nil, eventModifiers: functionEventModifiers, nsEventModifierFlags: .function),
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

extension Modifiers {

  #if canImport(AppKit)
  public init(from event: NSEvent) {
    self.init(from: event.modifierFlags)
  }

  public init(from flags: NSEvent.ModifierFlags) {
    self = ModifierKeyBridge.modifiers { flags.contains($0.nsEventModifierFlags) }
  }

  public var nsEventModifierFlags: NSEvent.ModifierFlags {
    NSEvent.ModifierFlags(from: self)
  }
  #endif

  public init(from eventModifiers: EventModifiers) {
    self = ModifierKeyBridge.modifiers { eventModifiers.contains($0.eventModifiers) }
  }

  public var eventModifiers: EventModifiers {
    EventModifiers(from: self)
  }

  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingNumericPad: Bool { contains(.numericPad) }

  public var isShiftOnly: Bool { self == [.shift] }
  public var isOptionOnly: Bool { self == [.option] }
  public var isCommandOnly: Bool { self == [.command] }
  public var isControlOnly: Bool { self == [.control] }
  public var isCapsLockOnly: Bool { self == [.capsLock] }
  public var isNumericPadOnly: Bool { self == [.numericPad] }
}

extension EventModifiers {
  public init(from modifiers: Modifiers) {
    self = ModifierKeyBridge.eventModifiers { mapping in
      guard let modifier = mapping.modifiers else { return false }
      return modifiers.contains(modifier)
    }
  }

  #if canImport(AppKit)
  public init(from flags: NSEvent.ModifierFlags) {
    self = ModifierKeyBridge.eventModifiers { flags.contains($0.nsEventModifierFlags) }
  }

  public var nsEventModifierFlags: NSEvent.ModifierFlags {
    NSEvent.ModifierFlags(from: self)
  }
  #endif
}

#if canImport(AppKit)
extension NSEvent.ModifierFlags {
  public init(from modifiers: Modifiers) {
    self = ModifierKeyBridge.nsEventModifierFlags { mapping in
      guard let modifier = mapping.modifiers else { return false }
      return modifiers.contains(modifier)
    }
  }

  public init(from eventModifiers: EventModifiers) {
    self = ModifierKeyBridge.nsEventModifierFlags { eventModifiers.contains($0.eventModifiers) }
  }

  public var modifiers: Modifiers {
    Modifiers(from: self)
  }

  public var eventModifiers: EventModifiers {
    EventModifiers(from: self)
  }
}
#endif
