//
//  LabelDescriptor+Role.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/2/2026.
//

/// Semantic intent attached to a ``LabelDescriptor``.
public enum ActionRole: Equatable, Sendable, Codable, Hashable {
  case success
  case destructive
  case error
  case warning
  case neutral
}
