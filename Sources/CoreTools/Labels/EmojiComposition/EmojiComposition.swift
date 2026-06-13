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
//  public let scale: CGFloat

  public init(
    emoji: [EmojiGlyph],
//    scale: CGFloat = 1.0,
  ) {
    self.emoji = emoji
//    self.scale = scale
  }
}

extension EmojiComposition {
  package static let example: Self = .init(
    emoji: [
      EmojiGlyph(
        "📎",
        offset: .init(x: -0.5, y: 0.2),
//        offset: CGSize(width: -30, height: 14),
        rotation: 4,
        scale: 0.8,
      ),
      EmojiGlyph(
        "✂️",
        offset: .init(x: 0.4, y: -0.2),
//        offset: CGSize(width: 26, height: -14),
        rotation: 16,
        scale: 1.0,
      ),
    ],
//    scale: 2.8,
  )
}
