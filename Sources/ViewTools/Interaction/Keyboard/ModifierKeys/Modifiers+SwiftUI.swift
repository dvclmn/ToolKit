//
//  Modifiers+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/6/2026.
//

import SwiftUI

extension Modifiers {

  public init(from eventModifiers: EventModifiers) {
    self = ModifierKeyBridge.modifiers { eventModifiers.contains($0.eventModifiers) }
  }

  public var eventModifiers: EventModifiers {
    EventModifiers(from: self)
  }

}

extension EventModifiers {
  
  public var displayName: String {
    let modifiers = Modifiers(from: self)
    return modifiers.displayString
  }
  
  public init(from modifiers: Modifiers) {
    self = ModifierKeyBridge.eventModifiers { mapping in
      guard let modifier = mapping.modifiers else { return false }
      return modifiers.contains(modifier)
    }
  }

  #if canImport(AppKit)
  public init(from event: NSEvent) {
    self.init(from: event.modifierFlags)
  }
  
  public init(from flags: NSEvent.ModifierFlags) {
    self = ModifierKeyBridge.eventModifiers { flags.contains($0.nsEventModifierFlags) }
  }

  public var nsEventModifierFlags: NSEvent.ModifierFlags {
    NSEvent.ModifierFlags(from: self)
  }
  #endif
}
