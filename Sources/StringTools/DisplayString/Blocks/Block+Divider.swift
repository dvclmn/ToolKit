//
//  Comp+Divider.swift
//  ToolKit
//
//  Created by Dave Coleman on 17/11/2025.
//

/// A simple divider block for display strings.
public struct Divider: Sendable {
  /// The text rendered for the divider.
  public let value: String

  /// Creates a divider with the supplied text.
  public init(value: String = "----------\n") {
    self.value = value
  }
}
