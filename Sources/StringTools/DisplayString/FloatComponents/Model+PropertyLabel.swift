//
//  Model+DisplayPair.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/7/2025.
//

import Foundation

/// Represents the text label for a property, e.g. "Width" / "W" for `CGSize.width`.
/// Knows nothing about values, separators, or float formatting.
public struct AbbreviableLabel: Sendable {

  /// The standard representation, e.g. `Width`.
  let label: String

  /// A more concise representation, e.g. `W` instead of `Width`.
  let abbreviated: String?

  public init(
    _ label: String,
    abbreviated: String? = nil,
  ) {
    self.label = label
    self.abbreviated = abbreviated
  }
}

extension AbbreviableLabel: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}

extension AbbreviableLabel {

  /// Returns the label text for the given display style, or `nil` for `.none`.
  public func abbreviableLabelText(with style: Self.Style) -> String {
    switch style {
      case .standard: label
      // Fall back to the standard label if no abbreviated label was supplied.
      case .abbreviated: abbreviated ?? label
    }
  }
}
