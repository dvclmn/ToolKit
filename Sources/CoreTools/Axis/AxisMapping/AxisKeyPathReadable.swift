//
//  AxisKeyPathReadable.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

import Foundation

/// A type whose two stored components can be read by logical axis.
public protocol AxisKeyPathReadable {
  associatedtype Component

  /// Path to the first storage slot, such as `width`, `x`, or `column`.
  static var primaryKey: KeyPath<Self, Component> { get }

  /// Path to the second storage slot, such as `height`, `y`, or `row`.
  static var secondaryKey: KeyPath<Self, Component> { get }

}
extension AxisKeyPathReadable {

  /// Returns the component along `axis`, resolved through `mapping`.
  public func value(
    along axis: GeometryAxis,
    mapping: AxisMapping = .default,
  ) -> Component {
    
    let keyPath = mapping.select(
      primary: Self.primaryKey,
      secondary: Self.secondaryKey,
      for: axis
    )
    return self[keyPath: keyPath]
  }
}
