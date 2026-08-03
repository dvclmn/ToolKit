//
//  DebugText+ViewExt.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/4/2026.
//

import SwiftUI
import StringTools

extension View {
  public func debugTextOverlay(
    isEnabled: Bool = true,
    edge: VerticalEdge = .bottom,
    alignment: Alignment = .bottomLeading,
    isMonospaced: Bool = false
  ) -> some View {
    modifier(
      DebugTextOverlayModifier(
        isEnabled: isEnabled,
        edge: edge,
        alignment: alignment,
        isMonospaced: isMonospaced
      )
    )
  }

  public func debugText(
    isEnabled: Bool = true,
    _ text: String
  ) -> some View {
    modifier(DebugItemModifier(text: text, isEnabled: isEnabled))
  }

  public func debugText(
    isEnabled: Bool = true,
    @DisplayStringBuilder _ text: () -> [DisplayBlock]
  ) -> some View {
    modifier(DebugItemModifier(text: text().output(), isEnabled: isEnabled))
  }
}
