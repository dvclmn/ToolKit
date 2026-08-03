//
//  Model+Labeled.swift
//  ToolKit
//
//  Created by Dave Coleman on 4/10/2025.
//

import AppKit

/// A label-and-value pair.
///
/// `Labeled` can be used as a standalone ``DisplayBlock`` such as
/// `"Dimensions: 260 x 410"`, or as an individual component inside
/// ``FloatComponentsLabeled`` such as `"W 260"`.
///
/// Separator ownership:
/// - The separator between this label and its value (`separator`, default `" "`) lives here.
/// - The separator between a top-level block label and its content (e.g. `": "`) is supplied
///   by the `DisplayBlock` rendering layer.
/// - The delimiter between sibling components (e.g. `" x "`) lives on `FloatComponentsLabeled`.
public struct Labeled: Sendable {

  /// The label displayed before the value.
  public let key: AbbreviableLabel

  /// The optional value displayed after the label.
  public let value: DisplayFragment?

  /// Separator between the label text and the value,
  /// e.g. the space in `W 260`. Defaults to `" "`.
  public let separator: String

  /// Per-item float format override. Inherits from context when `nil`.
  public let formatOverride: FloatDisplayFormat?
  public var styleOverride: AbbreviableLabel.Style?

  init(
    key: AbbreviableLabel,
    value: DisplayFragment?,
    separator: String = ": ",
    formatOverride: FloatDisplayFormat? = nil,
    styleOverride: AbbreviableLabel.Style? = nil,
  ) {
    self.key = key
    self.separator = separator
    self.value = value
    self.formatOverride = formatOverride
    self.styleOverride = styleOverride
  }
}

// MARK: - Convenience initialisers

extension Labeled {

  /// Creates a labelled value from a key string and optional value.
  public init(
    _ key: String,
    value: Any?,
    separator: String = ": ",
    format: FloatDisplayFormat? = nil,
  ) {
    self.init(
      key: AbbreviableLabel(key),
      value: DisplayFragment.make(from: value),
      separator: separator,
      formatOverride: format,
    )
  }
}

// MARK: - Rendering

/// SPI rendering helpers for consumers that need the individual label/value
/// pieces without exposing them as ordinary public API.
extension Labeled {

  /// Renders the label text only (no value or separator).
  @_spi(Internal) public func labelPart(with style: AbbreviableLabel.Style) -> String {
    key.abbreviableLabelText(with: style)
  }

  /// Renders the value only.
  @_spi(Internal) public static func valuePart(
    for label: Self,
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String = ", ",
  ) -> String? {
    return label.value?.render(
      using: format,
      with: labelStyle,
      delimiter: delimiter,
    )
  }
}

extension Labeled {

  // I THINK THIS SHOULD BE NAMED RENDER
  /// Renders `"<label><separator><value>"`, e.g. `"W 260"`.
  package func toString(
    using format: FloatDisplayFormat = .default,
    with labelStyle: AbbreviableLabel.Style = .standard,
  ) -> String {
    let effectiveFormat = formatOverride ?? format
    let effectiveStyle = styleOverride ?? labelStyle

    let label: String = labelPart(with: labelStyle)
    let sep: String = separator.stringValue
    
    let value: String? = Self.valuePart(
      for: self,
      using: effectiveFormat,
      with: effectiveStyle,
    )

    let result = [label, sep, value].compactMap { $0 }.joined()
    return result
  }
}
