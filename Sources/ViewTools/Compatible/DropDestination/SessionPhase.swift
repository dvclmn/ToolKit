//
//  SessionPhase.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

extension DropSessionCompatible {
  public enum Phase: Sendable, Hashable {
    case entering
    case active
    case exiting
    case ended(DropOperation)
    case dataTransferCompleted
  }
}

extension DropSessionCompatible.Phase {

  public var isTargeted: Bool {
    switch self {
      case .entering, .active: true
      case .exiting, .ended, .dataTransferCompleted: false
    }
  }

  public var displayName: String {
    switch self {
      case .entering: "Entering"
      case .active: "Active"
      case .exiting: "Exiting"
      case .ended: "Ended"
      case .dataTransferCompleted: "Data Transfer Completed"
    }
  }
}

@available(iOS 26, macOS 26, *)
extension DropSessionCompatible.Phase {
  public init(_ phase: DropSession.Phase) {
    self =
      switch phase {
        case .entering: .entering
        case .active: .active
        case .exiting: .exiting
        case .ended(let operation): .ended(operation)
        case .dataTransferCompleted: .dataTransferCompleted
        @unknown default: .active
      }
  }
}
