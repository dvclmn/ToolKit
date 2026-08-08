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
///         .readModifierKeys() // <- E.g. here
///     }
///   }
/// }
/// ```
struct ModifierKeysModifier: ViewModifier {

  @State private var modifierKeys: Modifiers = []
  @State private var previousNSEventKeys: NSEvent.ModifierFlags?

  let keysToWatch: EventModifiers
  let onModifiersChange: ((Modifiers) -> Void)?
  let onEventModifiersChange: ((EventModifiers) -> Void)?

  func body(content: Content) -> some View {

    if #available(macOS 15, iOS 18, *) {
      content
        .onModifierKeysChanged(
          mask: keysToWatch,
          initial: true,
        ) { _, new in

          let modifiers = Modifiers(from: new)
          self.modifierKeys = modifiers
          onModifiersChange?(modifiers)
          onEventModifiersChange?(new)
        }
        .environment(\.modifierKeys, modifierKeys)

    } else {
      #if canImport(AppKit)
      content
        .onAppear {
          NSEvent.addLocalMonitorForEvents(matching: [.flagsChanged]) { event in
            
            let currentFlags = event.modifierFlags.intersection(nsEventKeysToWatch)
            
            guard currentFlags != previousNSEventKeys else {
              return event // An untracked flag changed.
            }
            
            previousFlags = currentFlags
            onChange(currentFlags)
            return event
            
//            let modifiers = Modifiers(from: event.modifierFlags)
//            let eventModifiers = EventModifiers(from: event.modifierFlags)
            self.modifierKeys = modifiers
            onModifiersChange?(modifiers)
            onEventModifiersChange?(eventModifiers)

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
}


