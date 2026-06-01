//
//  CustomSymbol.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

/// A custom symbol reference using the `custom.` SF Symbols naming convention.
public enum CustomSymbol: String, Sendable, Codable {
  case artboard
  case zoom  // search, magnifying glass
  case terminal  // code
  case circleInRectangle

  public var id: String { rawValue }

  /// The string used to look up the symbol in UI layers.
  public var reference: String {
    let prefix: String = "custom."
    let name: String =
      switch self {
        case .artboard: "artboard"
        case .zoom: "magnifyingglass"
        case .terminal: "code.view"
        case .circleInRectangle: "circle.rectangle"
      }
    return prefix + name
  }
}
