//
//  DisplayFragment.swift
//  ToolKit
//
//  Created by Dave Coleman on 14/4/2026.
//

/// A type-erased display fragment.
///
/// `DisplayFragment` stores any value that can render itself with a
/// ``FloatDisplayFormat``, label style, and delimiter. This lets
/// ``DisplayBlock`` and ``Labeled`` keep a single value type instead of carrying
/// generic parameters through the display-string tree.
public struct DisplayFragment: Sendable {
  private let _render: @Sendable (FloatDisplayFormat, AbbreviableLabel.Style, String) -> String

  /// Wraps a renderable value.
  public init<R: DisplayFragmentRenderable>(_ base: R) {
    self._render = { format, style, delimiter in
      base.render(using: format, with: style, delimiter: delimiter)
    }
  }

  /// Renders the stored value using the supplied formatting context.
  public func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String,
  ) -> String {
    _render(format, labelStyle, delimiter)
  }
}

extension DisplayFragment {
  /// Creates a display fragment from an optional, dynamically typed value.
  public static func make(from value: Any?) -> DisplayFragment {
    switch value {
      case let val as FloatComponentsLabeled:
        return DisplayFragment(val)

      case let val as [CustomStringConvertible]:
        let values = val.enumerated().map { _, item in
          "  " + item.description.replacingOccurrences(of: "\n", with: "\n  ")
        }.joined(",\n\n")

        let joined = """
          [
          \(values)
          ]
          """

        return DisplayFragment("\n" + joined)

      case let val as CustomStringConvertible:
        return DisplayFragment(val.description)

      default: return DisplayFragment(String(describing: value))
    }
  }
}
