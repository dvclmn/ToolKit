//
//  EmojiGlyph.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/6/2026.
//

import CoreGraphics
import Foundation

extension EmojiComposition {
  
  /// A single emoji glyph and its placement metadata inside an emoji composition.
  public struct Glyph: Identifiable, Equatable, Sendable, Hashable, Codable {
    public let id: UUID
    public let character: Character
    public let offset: UnitOffset
    public let rotation: Double  // Degrees
    public let scale: CGFloat
    
    public init(
      id: UUID = UUID(),
      _ character: Character,
      offset: UnitOffset = .zero,
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
}

public struct UnitOffset: Sendable, Hashable, Codable {
  // [-1, 1] where 0 is centre, -1 is left/top, 1 is right/bottom
  public var x: CGFloat
  public var y: CGFloat

  public init(x: CGFloat = 0, y: CGFloat = 0) {
    self.x = x
    self.y = y
  }

  public static let zero = UnitOffset()
}

extension UnitOffset {
  public func offset(in size: CGSize) -> CGSize {
    CGSize(width: x * size.width / 2, height: y * size.height / 2)
  }
}
