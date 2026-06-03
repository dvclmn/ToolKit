//
//  Model+DisplayString.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/10/2025.
//


/// A rendered text description built from display blocks.
public struct DisplayString {

  private let components: [DisplayBlock]

  /// Separator inserted between each top-level block. Defaults to `"\n"`.
  private let lineSeparator: String

  /// How individual float values are formatted.
  private let format: FloatDisplayFormat

  /// How block-level labels are displayed. Separated from `format`
  /// because label styling is a presentation concern, not a float-formatting concern.
  private let labelStyle: AbbreviableLabel.Style

  public init(
    _ components: [DisplayBlock],
    separator: String,
    format: FloatDisplayFormat,
    labelStyle: AbbreviableLabel.Style,
  ) {
    self.components = components
    self.lineSeparator = separator
    self.format = format
    self.labelStyle = labelStyle
  }
}

extension DisplayString {

  /// Creates a display string with a result-builder body.
  public init(
    _ separator: String = "\n",
    format: FloatDisplayFormat = .default,
    labelStyle: AbbreviableLabel.Style = .standard,
    @DisplayStringBuilder _ content: () -> [DisplayBlock],
  ) {
    self.lineSeparator = separator
    self.format = format
    self.labelStyle = labelStyle
    self.components = content()
  }
}

extension DisplayString {
  /// The fully rendered text.
  public var text: String {
    components.output(
      lineSeparator: lineSeparator,
      labelStyle: labelStyle,
      format: format,
    )
  }

  /// The rendered top-level blocks, before joining with the line separator.
  public var lines: [String] {
    components.map { $0.render(using: format, with: labelStyle) }
  }

  /// Returns a copy that renders floating-point values with the supplied number
  /// of decimal places.
  public func decimalPlaces(_ places: Int) -> DisplayString {
    var newFormat = format
    newFormat.decimalPlaces = places
    return DisplayString(components, separator: lineSeparator, format: newFormat, labelStyle: labelStyle)
  }

  /// Returns a copy that renders labels with the supplied style.
  public func labelStyle(_ style: AbbreviableLabel.Style) -> DisplayString {
    DisplayString(components, separator: lineSeparator, format: format, labelStyle: style)
  }
}

extension Array where Element == DisplayBlock {
  /// Renders and joins the display blocks.
  public func output(
    lineSeparator: String = "\n",
    labelStyle: AbbreviableLabel.Style = .standard,
    format: FloatDisplayFormat = .default,
  ) -> String {
    lines(labelStyle: labelStyle, format: format).joined(lineSeparator)
  }

  /// Renders each display block independently.
  public func lines(
    labelStyle: AbbreviableLabel.Style = .standard,
    format: FloatDisplayFormat = .default,
  ) -> [String] {
    map { $0.render(using: format, with: labelStyle) }
  }
}
