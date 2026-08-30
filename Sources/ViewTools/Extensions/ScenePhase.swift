//
//  ScenePhase.swift
//  ToolKit
//
//  Created by Dave Coleman on 29/8/2026.
//

import SwiftUI

extension ScenePhase {
  public var displayName: String {
    switch self {
      case .background: "Background"
      case .inactive: "Inactive"
      case .active: "Active"
      @unknown default: "Unknown"
    }
  }
}
