//
//  RGBAConvertible.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/1/2026.
//

/// A type that can be initialised from normalised RGBA components.
///
/// This protocol is intentionally component-only. Labels, palette names, and
/// source metadata belong in ``NamedColour`` or another descriptor wrapper.
public protocol RGBAConvertible {
  init(r: Double, g: Double, b: Double, a: Double)
}
