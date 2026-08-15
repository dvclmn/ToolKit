//
//  ModifierKeyState.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/8/2026.
//

import SwiftUI

/// A type that represents both the pressed modifier keys,
/// and the modifier key mask
public struct ModifierKeyState: Sendable, Equatable {
  public let pressed: Modifiers
  public let observedMask: EventModifiers

  public init?(
    pressed: Modifiers?,
    mask: EventModifiers = .all,
  ) {
    guard let pressed else { return nil }
    self.pressed = pressed
    self.observedMask = mask
  }
}
