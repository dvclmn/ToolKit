//
//  DebugFrameModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/6/2025.
//

import SwiftUI

public struct DebugFrameModifier: ViewModifier {
  @Environment(\.isDebugMode) private var isDebugMode
  let label: String
  let labelOpacity: CGFloat
  let colour: Color
  let isEnabled: Bool

  public func body(content: Content) -> some View {
    content
      .border(colour.opacity(isEnabled ? 0.3 : 0.0), width: 1)
      .overlay(alignment: .topLeading) {
        if isEnabled, isDebugMode, !label.isEmpty {
          Text(label)
            .font(.caption2)
            .fixedSize(horizontal: true, vertical: false)
            .foregroundStyle(colour.opacity(0.8))
            .padding(.horizontal, 2)
            .background(Color.black.opacity(0.8))
            .opacity(labelOpacity)
            .padding(2)
        }
      }
  }
}
