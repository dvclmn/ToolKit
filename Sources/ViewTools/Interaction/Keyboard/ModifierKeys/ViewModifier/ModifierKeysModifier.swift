//
//  Untitled.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/5/2025.
//

import SwiftUI

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
        .environment(\.modifierKeys, modifierKeys)

    } else {
      #if canImport(AppKit)
      content
        .onAppear {
          NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in

            // The current modifier keys, filtered to only those requested
            let currentNSEventFlags = event.modifierFlags.intersection(nsEventKeysToWatch)

            guard currentNSEventFlags != previousNSEventFlags else {
              return event  // An untracked flag changed
            }

            previousNSEventFlags = currentNSEventFlags
            
            let modifiers = Modifiers(from: currentNSEventFlags)
            handleKeyChange(modifiers)
            
            return event

          }
        }
        .environment(\.modifierKeys, modifierKeys)
      #else
      content
      #endif
    }
  }
}

extension ModifierKeysModifier {
  private var nsEventKeysToWatch: NSEvent.ModifierFlags {
    keysToWatch.nsEventModifierFlags
  }
  
  private func handleKeyChange(_ modifiers: Modifiers) {
    self.modifierKeys = modifiers
    modifiersDidChange?(modifiers)
  }
}
