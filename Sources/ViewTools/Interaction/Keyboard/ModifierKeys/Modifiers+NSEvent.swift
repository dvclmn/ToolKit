//
//  Modifiers+NSEvent.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/6/2026.
//

#if canImport(AppKit)
import AppKit
import SwiftUI

// MARK: - Create Modifiers from NSEvent.ModifierFlags
extension Modifiers {
  public init(from event: NSEvent) {
    self.init(from: event.modifierFlags)
  }

  public init(from flags: NSEvent.ModifierFlags) {
    self = ModifierKeyBridge.modifiers { flags.contains($0.nsEventModifierFlags) }
  }

  public var nsEventModifierFlags: NSEvent.ModifierFlags {
    NSEvent.ModifierFlags(from: self)
  }
}

// MARK: - Create NSEvent.ModifierFlags from Modifiers
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
