//
//  LabeledComponent.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/10/2025.
//

import Foundation

/// A type with multiple named float properties.
/// E.g. `CGPoint` (x, y) or `CGSize` (width, height).
///
/// The type owns its ordered ``Labeled`` components and the delimiter between
/// sibling components. Block-level separators remain the responsibility of
/// ``DisplayBlock`` and ``DisplayString``.
///
/// Conforms to ``DisplayFragmentRenderable`` so composite values can participate
/// in the ``DisplayStringBuilder``.
public protocol FloatComponentsLabeled: DisplayFragmentRenderable, DisplayPresetRenderable {

  /// The ordered label+value components.
  /// E.g. `[("W", 260), ("H", 410)]` for a `CGSize`.
  var components: [Labeled] { get }

  func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String,
  ) -> String
}

extension FloatComponentsLabeled {

  /// Renders with a preset and the `.standard` label style.
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    render(
      using: preset.format,
      with: preset.labelStyle,
    )
  }
}

extension FloatComponentsLabeled {

  public func render(
    using format: FloatDisplayFormat = .default,
    with labelStyle: AbbreviableLabel.Style = .standard,
    delimiter: String = ", ",
  ) -> String {
    components
      .map { $0.toString(using: format, with: labelStyle) }
      .joined(delimiter)
  }
}
