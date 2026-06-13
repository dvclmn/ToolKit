//
//  EmojiComposition.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

import Foundation

/// A group of emoji glyphs rendered together as one icon-like composition.
public struct EmojiComposition: Sendable, Equatable, Codable, Hashable {
  public let emoji: [Emoji]
  public let scale: CGFloat

  public init(
    emoji: [Emoji],
    scale: CGFloat = 1.0,
  ) {
    self.emoji = emoji
    self.scale = scale
  }
}

extension EmojiComposition {
  package static let example: Self = .init(
    emoji: [
      Emoji(
        emoji: "📎",
        offset: CGSize(width: -30, height: 14),
        rotation: 4,
        scale: 0.8,
      ),
      Emoji(
        emoji: "✂️",
        offset: CGSize(width: 26, height: -14),
        rotation: 16,
        scale: 1.0,
      ),
    ],
    scale: 2.8,
  )
}
