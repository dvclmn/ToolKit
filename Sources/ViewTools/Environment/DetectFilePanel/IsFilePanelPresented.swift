//
//  IsFilePanelPresented.swift
//  ToolKit
//
//  Created by Dave Coleman on 29/8/2026.
//

import SwiftUI
import AppKit

// MARK: - Environment value
extension EnvironmentValues {
  @Entry public var isFilePanelPresented: Bool = false
}

// MARK: - View modifier
struct FilePanelDetectorModifier: ViewModifier {
  @State private var isPanelOpen = false
  
  let presentationDidChange: ((Bool) -> Void)?
  
  func body(content: Content) -> some View {
    content
      .environment(\.isFilePanelPresented, isPanelOpen)
      .onReceive(NotificationCenter.default.publisher(for: NSWindow.didBecomeKeyNotification)) { _ in
        checkPanelStatus()
      }
      .onReceive(NotificationCenter.default.publisher(for: NSWindow.didResignKeyNotification)) { _ in
        checkPanelStatus()
      }
      .onAppear {
        checkPanelStatus()
      }
  }
  
  private func checkPanelStatus() {
    // NSOpenPanel inherits from NSSavePanel, covering both panel types
    let panelActive = NSApp.windows.contains { window in
      window is NSSavePanel && window.isVisible
    }
    
    if isPanelOpen != panelActive {
      isPanelOpen = panelActive
      presentationDidChange?(panelActive)
    }
  }
}
