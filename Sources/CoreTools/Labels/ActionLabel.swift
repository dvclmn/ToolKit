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
