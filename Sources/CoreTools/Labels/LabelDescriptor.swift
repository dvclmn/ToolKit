//
//  LabelDescriptor.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/5/2025.
//

/// A lightweight label model for non-SwiftUI code.
public struct LabelDescriptor: Sendable, Codable, Equatable, Hashable {
  /// The visible text for the label.
  public var text: String

  /// An optional icon associated with the label.
  public let icon: IconLiteral?
}

extension LabelDescriptor {

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
  ) {
    self.text = text
    self.icon = icon
  }

  /// Creates a label whose icon is an SF Symbol name.
  ///
  /// The `symbol` argument is not defaulted so this initializer remains
  /// distinct from ``LabelDescriptor/init(_:icon:role:)``.
  public init(
    _ text: String,
    symbol symbolString: String?,
  ) {
    self.init(
      text,
      icon: symbolString.map { IconLiteral.symbol($0) },
    )
  }
}

extension LabelDescriptor: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension LabelDescriptor: CustomStringConvertible {
  public var description: String {
    return "LabelDescriptor[\"\(text)\", icon: \"\(icon?.toString ?? "")\"]"
  }
}
