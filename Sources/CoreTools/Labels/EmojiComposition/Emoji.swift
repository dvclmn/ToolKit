//
//  Emoji.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/6/2026.
//

import Foundation
import CoreGraphics

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
