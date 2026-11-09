//
//  TabBarVisibilityView.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/11/2026.
//

#if os(macOS)
import SwiftUI

@MainActor
final class WindowTabBarVisibilityView: NSView {
  var isVisible: Binding<Bool>?
  private var isObserving = false
  private var isUpdateScheduled = false

  override func viewDidMoveToWindow() {
    super.viewDidMoveToWindow()
    stopObserving()
    guard window != nil, isVisible != nil else { return }

    // AppKit posts this after updating its windows. Observing the application
    // also covers tab-group changes involving an unselected document window.
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(refreshVisibility),
      name: NSApplication.didUpdateNotification,
      object: NSApp
    )
    isObserving = true
    refreshVisibility()
  }

  func stopObserving() {
    NotificationCenter.default.removeObserver(
      self,
      name: NSApplication.didUpdateNotification,
      object: nil
    )
    isObserving = false
  }

  @objc func refreshVisibility() {
    guard isObserving, !isUpdateScheduled,
          let window, let isVisible,
          isVisible.wrappedValue != (window.tabGroup?.isTabBarVisible ?? false)
            else { return }

    isUpdateScheduled = true
    // Defer the binding write out of AppKit/SwiftUI's current update pass.
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      self.isUpdateScheduled = false
      guard self.isObserving, let window = self.window,
            let binding = self.isVisible
              else { return }

      // Read again: the view, binding or tab group may have changed meanwhile.
      let value = window.tabGroup?.isTabBarVisible ?? false
      if binding.wrappedValue != value {
        binding.wrappedValue = value
      }
    }
  }
}

#endif
