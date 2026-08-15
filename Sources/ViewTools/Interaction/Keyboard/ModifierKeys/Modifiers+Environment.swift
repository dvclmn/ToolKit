//
//  Modifiers+Environment.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/4/2026.
//

import SwiftUI

extension EnvironmentValues {
  //  @Entry public var modifierKeys: Modifiers = []
  @Entry public var modifierKeyState: ModifierKeyState?

  public var modifierKeys: Modifiers? { modifierKeyState?.pressed }
  public var modifierKeysNative: EventModifiers? { modifierKeys?.eventModifiers }
}
