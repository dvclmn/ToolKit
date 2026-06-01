//
//  QuickLabel+Role.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/2/2026.
//

/// Semantic intent attached to a ``QuickLabel``.
public enum ActionRole: Equatable, Sendable, Codable, Hashable {
  case success
  case destructive
  case error
  case warning
  case neutral
}
