//
//  QuickLabel.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/5/2025.
//

/// A lightweight, serialisable label model for non-SwiftUI code.
public struct QuickLabel: Sendable, Codable, Equatable, Hashable {
  /// The visible text for the label.
  public var text: String

  /// An optional icon associated with the label.
  public let icon: IconLiteral?

  /// An optional semantic role for styling or ordering.
  public let role: ActionRole?
}

extension QuickLabel {

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
    role: ActionRole? = nil,
  ) {
    self.text = text
    self.icon = icon
    self.role = role
  }

  /// Creates a label whose icon is an SF Symbol name.
  ///
  /// The `symbol` argument is not defaulted so this initializer remains
  /// distinct from ``QuickLabel/init(_:icon:role:)``.
  public init(
    _ text: String,
    symbol symbolString: String?,
    role: ActionRole? = nil,
  ) {
    self.init(
      text,
      icon: symbolString.map { IconLiteral.symbol($0) },
      role: role,
    )
  }
}

extension QuickLabel: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension QuickLabel: CustomStringConvertible {
  public var description: String {
    return "QuickLabel[\"\(text)\", icon: \"\(icon?.toString ?? "")\"]"
  }
}
