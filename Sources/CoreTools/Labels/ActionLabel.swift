//
//  ActionLabel.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/6/2026.
//

public struct ActionLabel: Sendable, Codable, Equatable, Hashable {
  public var label: LabelDescriptor
  public var role: ActionRole?
}

/// Semantic intent attached to a ``LabelDescriptor``.
public enum ActionRole: Equatable, Sendable, Codable, Hashable {
  case success
  case destructive
  case error
  case warning
  case neutral
}
