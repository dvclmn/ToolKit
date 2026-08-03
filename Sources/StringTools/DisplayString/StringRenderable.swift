//
//  StringRenderable.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public protocol StringRenderable: Sendable {
  var stringValue: String { get }
}

// MARK: - String types
extension String: StringRenderable {
  public var stringValue: String { self }
}

extension AttributedString: StringRenderable {
  public var stringValue: String { String(self.characters) }
}

extension Character: StringRenderable {
  public var stringValue: String { String(self) }
}

extension Substring: StringRenderable {
  public var stringValue: String { String(self) }
}

// MARK: - Primitives
extension Int: StringRenderable {
  public var stringValue: String { String(self) }
}
extension Int64 {
  public var stringValue: String { String(self) }
}

extension Bool: StringRenderable {
  public var stringValue: String {
    displayAs(.standard)
//    self ? "true" : "false"
  }
}

// MARK: - Collections
extension Array: StringRenderable where Element: StringRenderable {
  public var stringValue: String { map(\.stringValue).joined(separator: ", ") }
}
