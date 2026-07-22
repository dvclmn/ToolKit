//
//  Compat+SwipeActionsContainer.swift
//  ToolKit
//
//  Created by Dave Coleman on 20/7/2026.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func swipeActionsContainerCompatible() -> some View {
    if #available(macOS 27.0, iOS 27.0, *) {
      swipeActionsContainer()
    } else {
      self
    }
  }
}
