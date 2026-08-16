//
//  ModifierKeysModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/5/2025.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// Important: Don't forget to provide the entry point for the modifier somewhere
/// in the View hierarchy, high enough to cover Views that need the modifiers.
///
/// ```
/// import SwiftUI
///
/// @main
/// struct ExampleApp: App {
///
///   var body: some Scene {
///     WindowGroup {
///       ContentView()
///         .readModifierKeys()
///     }
///   }
/// }
/// ```
struct ModifierKeysModifier: ViewModifier {

  @State private var modifierKeys: Modifiers = []
  @State private var eventMonitor: Any?
  @State private var previousNSEventFlags: NSEvent.ModifierFlags?

  let keysToWatch: EventModifiers
  let modifiersDidChange: ((Modifiers) -> Void)?

  func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *) {
      content
        .onModifierKeysChanged(
          mask: keysToWatch,
          initial: true,
        ) { _, new in

          let modifiers = Modifiers(from: new)
          handleKeyChange(modifiers)
        }
        .environment(\.modifierKeyState, modifierKeyState)

    } else {
      #if canImport(AppKit)
      content
        .onAppear {
          startMonitoringNSEvents()
        }
        .onDisappear {
          stopMonitoringNSEvents()
        }
        .environment(\.modifierKeyState, modifierKeyState)
      #else
      content
      #endif
    }
  }
}

extension ModifierKeysModifier {

  private var modifierKeyState: ModifierKeyState? {
    .init(pressed: modifierKeys, mask: keysToWatch)
  }

  #if canImport(AppKit)
  private var nsEventKeysToWatch: NSEvent.ModifierFlags {
    keysToWatch.nsEventModifierFlags
  }

  private func startMonitoringNSEvents() {
    guard eventMonitor == nil else { return }

    let currentNSEventFlags = NSEvent.modifierFlags.intersection(nsEventKeysToWatch)
    previousNSEventFlags = currentNSEventFlags

    let currentModifiers = Modifiers(from: currentNSEventFlags)
    modifierKeys = currentModifiers

    /// Match SwiftUI's `initial` behaviour: only notify the callback on
    /// appearance when at least one watched modifier is already pressed.
    if !currentModifiers.isEmpty {
      modifiersDidChange?(currentModifiers)
    }

    eventMonitor = NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
      // The current modifier keys, filtered to only those requested
      let currentNSEventFlags = event.modifierFlags.intersection(nsEventKeysToWatch)

      guard currentNSEventFlags != previousNSEventFlags else {
        return event  // An untracked flag changed
      }

      previousNSEventFlags = currentNSEventFlags
      handleKeyChange(Modifiers(from: currentNSEventFlags))

      return event
    }
  }

  private func stopMonitoringNSEvents() {
    if let eventMonitor {
      NSEvent.removeMonitor(eventMonitor)
      self.eventMonitor = nil
    }

    previousNSEventFlags = nil
    modifierKeys = []
  }
  #endif

  private func handleKeyChange(_ modifiers: Modifiers) {
    self.modifierKeys = modifiers
    modifiersDidChange?(modifiers)
  }
}
