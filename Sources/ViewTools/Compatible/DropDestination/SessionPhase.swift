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
