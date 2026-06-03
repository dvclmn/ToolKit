//
//  StringRenderable.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public protocol StringRenderable: Sendable {
  var toString: String { get }
}

// MARK: - String types
extension String: StringRenderable {
  public var toString: String { self }
}

extension AttributedString: StringRenderable {
  public var toString: String { String(self.characters) }
}

extension Character: StringRenderable {
  public var toString: String { String(self) }
}

extension Substring: StringRenderable {
  public var toString: String { String(self) }
}

// MARK: - Primitives
extension Int: StringRenderable {
  public var toString: String { String(self) }
}

extension Bool: StringRenderable {
  public var toString: String { self ? "true" : "false" }
}

// MARK: - Collections
extension Array: StringRenderable where Element: StringRenderable {
  public var toString: String { map(\.toString).joined(separator: ", ") }
}

// MARK: - Other
