//
//  DebugViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 4/8/2026.
//

import SwiftUI

// MARK: - Debug Circle
extension View {
  public func debugCircle(
    _ location: CGPoint?,
    diameter: CGFloat = 10,
  ) -> some View {
    self.modifier(
      DebugCircleModifier(
        location: location,
        diameter: diameter,
      )
    )
  }
}

// MARK: - Debug Frame

// debugFrame will only show if Env value `isDebugMode`
// and isEnabled are set to true
extension View {
  public func debugFrame(
    _ text: String,
    colour: Color,
    labelOpacity: CGFloat = 0.85,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      DebugFrameModifier(
        label: text,
        labelOpacity: labelOpacity,
        colour: colour,
        isEnabled: isEnabled,
      )
    )
  }

  public func debugFrame(
    colour: Color,
    labelOpacity: CGFloat = 0.85,
    isEnabled: Bool = true,
  ) -> some View {
    debugFrame(
      "",
      colour: colour,
      labelOpacity: labelOpacity,
      isEnabled: isEnabled,
    )
  }
}

// MARK: - Debug Hover point
extension View {
  public func debugHoverPoint(
    _ point: CGPoint?,
    in containerSize: CGSize,
  ) -> some View {
    self.modifier(
      DebugHoverPointModifier(
        point: point,
        containerSize: containerSize,
      )
    )
  }
}
