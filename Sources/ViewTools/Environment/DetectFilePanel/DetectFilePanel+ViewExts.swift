//
//  DetectFilePanel+ViewExts.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/8/2026.
//

import SwiftUI

extension View {
  public func detectFilePanels() -> some View {
    self.modifier(FilePanelDetectorModifier(presentationDidChange: nil))
  }
  
  public func detectFilePanels(
    onChange perform: @escaping (Bool) -> Void,
  ) -> some View {
    self.modifier(
      FilePanelDetectorModifier(presentationDidChange: perform)
    )
  }
}
