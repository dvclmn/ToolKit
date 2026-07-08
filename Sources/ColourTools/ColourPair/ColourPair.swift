//
//  ColourPair.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

public struct ColourPair: Sendable, Codable, Hashable {
  public let foreground: ColourDescriptor
  public let background: ColourDescriptor?

  public init(
    foreground: ColourDescriptor,
    background: ColourDescriptor? = nil
  ) {
    self.foreground = foreground
    self.background = background
  }

  public init(
    _ foreground: ColourDescriptor,
    background: ColourDescriptor? = nil
  ) {
    self.init(
      foreground: foreground,
      background: background
    )
  }
}
