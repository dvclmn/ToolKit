//
//  AbbreviableLabelStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/2/2026.
//

extension AbbreviableLabel {
  /// Controls which form of an ``AbbreviableLabel`` is rendered.
  public enum Style: Equatable, Sendable {
    /// Suppress the label.
    //    case none

    /// Render the standard label.
    case standard

    /// Render the abbreviated label when available.
    case abbreviated
  }
}

extension AbbreviableLabel.Style {
  public var isAbbreviated: Bool {
    if case .abbreviated = self {
      return true
    }
    return false
  }
}
