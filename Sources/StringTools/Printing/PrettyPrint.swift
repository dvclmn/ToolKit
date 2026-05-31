//
//  PrettyPrint.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/11/2025.
//

package protocol PrettyPrintable {
  func pretty(_ config: PrettyPrintConfig, depth: Int) -> String
  func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String
}

// MARK: - Default Implementation

extension PrettyPrintable {

  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    guard depth < config.maxDepth else { return config.overflowDescription(for: self) }

    let ind = config.indent(depth)
    let nextInd = config.indent(depth + 1)

    let body = prettyBody(config, depth: depth + 1)
      .split(separator: "\n")
      .map { "\(nextInd)\($0)" }
      .joined(separator: "\n")

    return """
      \(config.typeName(self)){
      \(body)
      \(ind)}
      """
  }

  /// Default empty body (for primitives, or types that don’t have nested properties)
  package func prettyBody(_ config: PrettyPrintConfig, depth: Int) -> String { "" }

  package var pretty: String {
    pretty(.default, depth: 0)
  }
}
