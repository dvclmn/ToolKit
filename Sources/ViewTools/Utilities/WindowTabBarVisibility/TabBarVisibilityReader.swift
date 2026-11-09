//
//  TabBarVisibilityReader.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/11/2026.
//

#if os(macOS)

import SwiftUI

@MainActor
struct WindowTabBarVisibilityReader: NSViewRepresentable {
  let isVisible: Binding<Bool>

  func makeNSView(context: Context) -> WindowTabBarVisibilityView {
    let view = WindowTabBarVisibilityView()
    view.isVisible = isVisible
    return view
  }

  func updateNSView(_ view: WindowTabBarVisibilityView, context: Context) {
    // A representable can receive a new binding without recreating its NSView.
    view.isVisible = isVisible
    view.refreshVisibility()
  }

  static func dismantleNSView(_ view: WindowTabBarVisibilityView, coordinator: ()) {
    view.stopObserving()
    view.isVisible = nil
  }
}
#endif
