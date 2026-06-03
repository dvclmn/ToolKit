//
//  DisplayRenderable.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/1/2026.
//

/// A value that can render itself using a ``FloatDisplayPreset``.
///
/// Use this for concise call sites where a preset is enough. Types that need
/// full control can expose ``FloatDisplayFormat`` directly through
/// ``FloatFormattable`` or ``FloatComponentsLabeled``.
public protocol DisplayPresetRenderable: Sendable {
  var displayString: String { get }
  func displayString(_ preset: FloatDisplayPreset) -> String
}

extension DisplayPresetRenderable {
  /// Renders the value using the `.standard` preset.
  public var displayString: String {
    displayString(.standard)
  }

  @available(
    *, deprecated, renamed: "displayString(_:)",
    message: "Prefer new FloatDisplayPreset-based method. Use preset .wholeNumber for 0 decimal places."
  )
  public func displayString(places: Int) -> String {
    displayString(.wholeNumber)
  }
}
