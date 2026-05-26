//
//  AxisAddressable.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// A type whose two stored components can be written by logical axis.
///
/// Conforming types need writable stored components or computed properties for
/// both primary and secondary storage slots.
public protocol AxisKeyPathWritable: AxisKeyPathReadable {
  associatedtype Component

  /// Path to the first storage slot, such as `width`, `x`, or `column`.
  static var primaryWritableKey: WritableKeyPath<Self, Component> { get }

  /// Path to the second storage slot, such as `height`, `y`, or `row`.
  static var secondaryWritableKey: WritableKeyPath<Self, Component> { get }
}

extension AxisKeyPathWritable {
  public static var primaryKey: KeyPath<Self, Component> { primaryWritableKey }
  public static var secondaryKey: KeyPath<Self, Component> { secondaryWritableKey }

  /// Returns a copy with the component along `axis` replaced by `newValue`.
  public func setting(
    _ newValue: Component,
    along axis: GeometryAxis,
    mapping: AxisMapping = .default
  ) -> Self {
    var copy = self
    let kp = mapping.select(
      primary: Self.primaryWritableKey,
      secondary: Self.secondaryWritableKey,
      for: axis
    )
    copy[keyPath: kp] = newValue
    return copy
  }
}
