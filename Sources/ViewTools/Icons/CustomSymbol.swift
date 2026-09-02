//
//  CustomSymbol.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import CoreTools
import Foundation

/// A custom symbol reference using the `custom.` SF Symbols naming convention.
public enum CustomSymbol: String, CaseIterable, Identifiable, Sendable, Codable {
  case artboard
  case zoom  // search, magnifying glass
  case terminal  // code
  case terminalFill
  case circleInRectangle12

  public var id: CustomSymbolID {
    .init(rawValue: rawValue)
  }

  public init?(id: CustomSymbolID) {
    self.init(rawValue: id.rawValue)
  }

  /// The string used to look up the symbol in UI layers.
  public var assetName: String {
    let prefix: String = "custom."
    let name: String =
      switch self {
        case .artboard: "artboard"
        case .zoom: "magnifyingglass"
        case .terminal: "code.view"
        case .terminalFill: "code.view.fill"
        case .circleInRectangle12: "circle.rectangle"
      }
    return prefix + name
  }
}

extension CustomSymbol {
  public var iconLiteral: IconLiteral {
    .customSymbol(id)
  }
}
