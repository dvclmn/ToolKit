//
//  DoubleTapEscape.swift
//  Helpers
//
//  Created by Dave Coleman on 8/9/2024.
//

#if canImport(AppKit)

import SwiftUI

public struct EscapeKeyDoubleTapModifier: ViewModifier {
  var action: () -> Void
  var buffer: Int

  @State private var lastEscapePressDate: Date?

  public func body(content: Content) -> some View {
    content
      .onAppear {
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) { event in
          self.handle(event: event)
          return event
        }
      }
  }

  private func handle(event: NSEvent) {
    guard event.keyCode == 53 else {  // 53 is the keycode for Escape
      return
    }

    let now = Date()

    if let lastPress = lastEscapePressDate,
      now.timeIntervalSince(lastPress) * 1000 < Double(buffer)
    {
      action()
      lastEscapePressDate = nil  // reset after action
    } else {
      lastEscapePressDate = now
    }
  }
}

extension View {
  /// Buffer is in milliseconds
  public func onEscapeKeyDoubleTap(
    buffer: Int = 300,
    perform action: @escaping () -> Void
  ) -> some View {
    self.modifier(
      EscapeKeyDoubleTapModifier(
        action: action,
        buffer: buffer
      )
    )
  }
}

#endif
