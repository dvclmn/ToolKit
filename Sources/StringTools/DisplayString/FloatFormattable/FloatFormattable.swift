//
//  DisplayString.swift
//  ToolKit
//
//  Created by Dave Coleman on 4/7/2025.
//


import Foundation

/// A floating-point value that can render itself using ``FloatDisplayFormat``.
public protocol FloatFormattable: BinaryFloatingPoint, DisplayFragmentRenderable, DisplayPresetRenderable {
  func render(using format: FloatDisplayFormat) -> String
}

/// Grouping strategy used by floating-point format styles.
public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

extension FloatFormattable {
  /// Renders the value using a display preset.
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    render(using: preset.format)
  }

  /// Renders the value as a display fragment.
  public func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String,
  ) -> String {
    render(using: format)
  }
}

extension Double: FloatFormattable {}
extension CGFloat: FloatFormattable {}
extension Float: FloatFormattable {}
