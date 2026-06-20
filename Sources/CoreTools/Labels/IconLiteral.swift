//
//  IconLiteral.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

/// A serialisable icon reference that can be rendered by UI-facing modules.
public enum IconLiteral: Sendable, Equatable, Codable, Hashable {
  case emoji(String)
  case emojiComposition(EmojiComposition)
  case symbol(String)  // Uses Image(systemName:)
  case customSymbol(CustomSymbol)  // Uses Image(_:bundle:)
}

extension IconLiteral: ExpressibleByStringLiteral {
  
  /// Creates an SF Symbol icon reference from a string literal.
  public init(stringLiteral value: String) {
    self = .symbol(value)
  }
}

extension IconLiteral {

  /// A simple string representation suitable for debugging and fallback labels.
  public var toString: String {
    switch self {
      case .emoji(let string): string
      case .emojiComposition(let comp):
        comp.emoji.map { String($0.character) }.joined(separator: "")
      case .symbol(let string): string
      case .customSymbol(let symbol): symbol.reference
    }
  }

  public var isEmoji: Bool {
    if case .emoji = self {
      return true
    }
    return false
  }

  public var isEmojiComposition: Bool {
    if case .emojiComposition = self {
      return true
    }
    return false
  }

  public var isSymbol: Bool {
    if case .symbol = self {
      return true
    }
    return false
  }

  public var isCustomSymbol: Bool {
    if case .customSymbol = self {
      return true
    }
    return false
  }

}
