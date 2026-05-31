//
//  PrettyPrint.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

package struct PrettyPrintConfig: Sendable {
  package var maxDepth: Int = 10
  package var indentSize: Int = 2
  package var indentChar: Character = " "
  package var arrayPrefix: String = "["
  package var arraySuffix: String = "]"
  package var dictPrefix: String = "{"
  package var dictSuffix: String = "}"
  package var showTypeNames: Bool = true
  package var compactCollections: Bool = false  // Single line for small collections
  package var compactThreshold: Int = 3  // Max items before expanding
  package var keyValueSeparator: String = ": "
  package var itemSeparator: String = ","

  package static let `default` = PrettyPrintConfig()
  package static let compact = PrettyPrintConfig(
    compactCollections: true,
    compactThreshold: 5
  )
}

extension PrettyPrintConfig {

  package func overflowDescription<T>(for value: T) -> String {
    "\(typeName(value)){...}"
  }

  package func indent(_ depth: Int) -> String {
    String(repeating: indentChar, count: depth * indentSize)
  }

  package func typeName<T>(_ value: T) -> String {
    guard showTypeNames else { return "" }
    let type = String(describing: type(of: value))
    return "<\(type)> "
  }
}

// MARK: - Optional

extension Optional: PrettyPrintable where Wrapped: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    switch self {
      case .none:
        return "\(config.typeName(self))nil"
      case .some(let value):
        return value.pretty(config, depth: depth)
    }
  }
}
