//
//  EmojiGlyph.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/6/2026.
//

import CoreGraphics
import Foundation

/// A single emoji glyph and its placement metadata inside an emoji composition.
public struct EmojiGlyph: Identifiable, Equatable, Sendable, Hashable, Codable {
  public let id: UUID
  public let character: Character
  public let offset: CGSize
  public let rotation: Double  // Degrees
  public let scale: CGFloat

  public init(
    id: UUID = UUID(),
    _ character: Character,
    offset: CGSize = .zero,
    rotation: Double = .zero,
    scale: CGFloat = 1.0,
  ) {
    self.id = id
    self.character = character
    self.offset = offset
    self.rotation = rotation
    self.scale = scale
  }
}
