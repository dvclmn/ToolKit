//
//  EmojiComposition.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

import CoreGraphics
import Foundation

/// A single emoji glyph and its placement metadata inside an emoji composition.
public struct Emoji: Identifiable, Equatable, Sendable, Hashable, Codable {
  public let id: UUID
  public let emoji: Character
  public let offset: CGSize

  /// Rotation in degrees.
  public let rotation: Double

  public let scale: CGFloat

  public init(
    id: UUID = UUID(),
    emoji: Character,
    offset: CGSize = .zero,
    rotation: Double = .zero,
    scale: CGFloat = 1.0,
  ) {
    self.id = id
    self.emoji = emoji
    self.offset = offset
    self.rotation = rotation
    self.scale = scale
  }
}

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
