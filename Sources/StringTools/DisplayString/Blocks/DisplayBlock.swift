//
//  DisplayBlock.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/10/2025.
//

import AppKit
import Foundation

/// A top-level node in a display string.
///
/// Each block knows how to render itself using a floating-point format and
/// label style supplied by ``DisplayString``.
public enum DisplayBlock: Sendable {
  case text(DisplayFragment)
  case labeled(Labeled)
  case indented(Indented)
  case divider(Divider)
}

extension DisplayBlock {

  /// Renders the block using the supplied formatting context.
  public func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String = ", ",
  ) -> String {
    let string: String? =
      switch self {
        case .text(let fragment):
          fragment.render(using: format, with: labelStyle, delimiter: delimiter)

        case .labeled(let label):
          label.toString(using: format, with: labelStyle)

        case .divider(let text):
          text.value

        case .indented(let indented):
          indented.render(using: format, with: labelStyle)
      }

    return string ?? ""
  }
}

extension DisplayBlock: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self = .text(.make(from: value))
  }
}
