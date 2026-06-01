//
//  AxisSelectable.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

/// A direction-like value that can be remapped across logical axes.
///
/// Useful for values such as `Edge` and `Alignment`, which represent directions
/// rather than storing scalar components.
public protocol AxisOrientable {
  /// Returns the equivalent value under a different axis mapping.
  func mapped(by mapping: AxisMapping) -> Self
}
