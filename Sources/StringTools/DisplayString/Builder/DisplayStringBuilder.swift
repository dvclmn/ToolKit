//
//  SequenceBuilder.swift
//  ToolKit
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

/// A result builder that assembles ``DisplayBlock`` values.
@resultBuilder
public struct DisplayStringBuilder {

  public static func buildBlock(_ components: [DisplayBlock]...) -> [DisplayBlock] {
    components.flatMap { $0 }
  }

  public static func buildOptional(_ component: [DisplayBlock]?) -> [DisplayBlock] {
    component ?? []
  }

  public static func buildEither(first: [DisplayBlock]) -> [DisplayBlock] { first }
  public static func buildEither(second: [DisplayBlock]) -> [DisplayBlock] { second }

  public static func buildArray(_ components: [[DisplayBlock]]) -> [DisplayBlock] {
    components.flatMap { $0 }
  }
}

// MARK: - buildExpression overloads
extension DisplayStringBuilder {

  /// Adds support for a pre-built array of blocks.
  public static func buildExpression(_ expression: [DisplayBlock]) -> [DisplayBlock] {
    expression
  }

  /// Adds support for a single block.
  public static func buildExpression(_ expression: DisplayBlock) -> [DisplayBlock] {
    [expression]
  }

  /// Adds support for a ``Labeled`` block.
  public static func buildExpression(_ value: Labeled) -> [DisplayBlock] {
    [.labeled(value)]
  }

  /// Adds support for an ``Indented`` block.
  public static func buildExpression(_ value: Indented) -> [DisplayBlock] {
    [.indented(value)]
  }

  /// Adds support for a ``Divider`` block.
  public static func buildExpression(_ value: Divider) -> [DisplayBlock] {
    [.divider(value)]
  }

  /// Adds support for line-based indented content.
//  public static func buildExpression(_ value: IndentedLines) -> [DisplayBlock] {
//    guard !value.lines.isEmpty else { return [] }
//    return [.indented(.makeFromLines(value))]
//  }

  /// Adds support for values that already provide a description.
  public static func buildExpression(_ value: any CustomStringConvertible) -> [DisplayBlock] {
    [.text(.make(from: value))]
  }
  
  /// Adds support for optional values that provide a description.
  public static func buildExpression(_ value: (any CustomStringConvertible)?) -> [DisplayBlock] {
    [.text(.make(from: value))]
  }
}
