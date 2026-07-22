//
//  Compat+TabViewStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 24/9/2025.
//

import SwiftUI

/// A tab view style that is available on macOS 15 and later.
///
/// On macOS 14, ``View/tabViewStyleCompatible(_:)`` falls back to the system
/// automatic tab view style.
public enum TabViewStyleCompatible: Hashable, Sendable {
  case automatic
  case grouped
  case sidebarAdaptable
  case tabBarOnly
}

extension View {
  /// Applies a compatible tab view style.
  ///
  /// The concrete SwiftUI tab view style is selected within the availability
  /// check, which lets callers use styles such as `.grouped` while supporting
  /// macOS 14.
  @ViewBuilder
  public func tabViewStyleCompatible(_ style: TabViewStyleCompatible) -> some View {
    if #available(macOS 15.0, *) {
      switch style {
        case .automatic:
          tabViewStyle(.automatic)
        case .grouped:
          tabViewStyle(.grouped)
        case .sidebarAdaptable:
          tabViewStyle(.sidebarAdaptable)
        case .tabBarOnly:
          tabViewStyle(.tabBarOnly)
      }
    } else {
      tabViewStyle(.automatic)
    }
  }
}
