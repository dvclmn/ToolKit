//
//  EmojiComposition.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

import Foundation

/// A group of emoji glyphs rendered together as one icon-like composition.
public struct EmojiComposition: Sendable, Equatable, Codable, Hashable {
  public let emoji: [EmojiGlyph]

  public init(
    emoji: [EmojiGlyph]
  ) {
    self.emoji = emoji
  }
}

extension EmojiComposition {
  package static let example: Self = .init(
    emoji: [
      EmojiGlyph(
        "📎",
        offset: .init(x: -0.5, y: 0.2),
        rotation: 4,
        scale: 0.8,
      ),
      EmojiGlyph(
        "✂️",
        offset: .init(x: 0.4, y: -0.2),
        rotation: 16,
        scale: 1.0,
      ),
    ]
  )
}
