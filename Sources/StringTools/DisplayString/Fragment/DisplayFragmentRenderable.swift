//
//  DisplayElement.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/2/2026.
//

/// A value that can render itself as a display-string fragment.
public protocol DisplayFragmentRenderable: Sendable {
  func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String,
  ) -> String
}

extension String: DisplayFragmentRenderable {
  /// Returns the string unchanged.
  public func render(
    using format: FloatDisplayFormat,
    with labelStyle: AbbreviableLabel.Style,
    delimiter: String,
  ) -> String { self }
}

