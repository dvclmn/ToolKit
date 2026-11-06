//
//  ViewportIndicatorModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI
import StringTools

public struct ViewportSizeIndicatorModifier: ViewModifier {
  @Environment(\.viewportRect) private var viewportRect

  public func body(content: Content) -> some View {
    content
      .overlay {
        OverlayView()
        .monospaced()
        .padding(6)
        .background(.black.secondary)
        .allowsHitTesting(false)
      }
  }
}
extension ViewportSizeIndicatorModifier {

  @ViewBuilder
  private func OverlayView() -> some View {
    if let viewportRect {
      Text(overlayText(viewportRect))
    } else {
      Text("⚠️ No value for `viewportRect` in the Environment.")
    }
  }
  private func overlayText(_ rect: CGRect) -> String {
    DisplayString {
      Indented("Viewport Rect") {
        Labeled("Origin", value: rect.origin)
        Labeled("Size", value: rect.size)
      }
    }.text
  }
}

extension View {
  public func viewportRectIndicator() -> some View {
    self.modifier(ViewportSizeIndicatorModifier())
  }
}
