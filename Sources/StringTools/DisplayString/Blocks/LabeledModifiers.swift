//
//  LabeledModifiers.swift
//  ToolKit
//
//  Created by Dave Coleman on 14/4/2026.
//

extension Labeled {
  /// Returns a copy whose nested labelled values use the supplied label style.
  public func labelStyle(
    _ style: AbbreviableLabel.Style
  ) -> Self {
    var result = self
    result.styleOverride = style
    return result
  }
}
