//
//  Model+Indented.swift
//  ToolKit
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// A display block that renders nested content with tree-style indentation.
public struct Indented: Sendable {
  /// Optional text rendered before the indented content.
  public let title: String?
  
  /// The blocks rendered inside the indented section.
  public let content: [DisplayBlock]
  
  let displayStyle: DisplayStyle
}

extension Indented {
  /// Creates an indented block from a result-builder body.
  public init(
    _ title: String? = nil,
    @DisplayStringBuilder content: () -> [DisplayBlock],
  ) {
    self.title = title
    self.content = content()
  }

  public func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style = .standard,
  ) -> String {

    let blocks =
      content.isEmpty
      ? ["(No items)"]
      : content.map {
        $0.render(using: format, with: labelStyle)
      }

    let elements = indentedElements(content: blocks)

    let result = elements.reduce(into: "") { partial, item in
      partial += "\n" + item
    }

    let effectiveTitle = title ?? ""

    return effectiveTitle + result + "\n"

  }

  private func indentedElements(
    content: [String],
    indent: String = "  ",
    isLastElement: Bool = false,
  ) -> [String] {
    var builder = LineRenderer(indent: indent)
    return builder.build(from: content)
  }
}

extension Indented {
  /// for ``DisplayStringBuilder``
  static func makeFromLines (_ indentedLines: IndentedLines) -> Self {
    let blocks: [DisplayBlock] = indentedLines.lines.map {
      DisplayBlock.text(DisplayFragment($0))
    }
    return Self.init(title: indentedLines.title, content: blocks)
  }

}
