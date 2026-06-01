//
//  NamedItem.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

// MARK: - Name
/// A value that can provide a display name.
public protocol NamedItem {
  var name: String { get }
}

// MARK: - Icon
/// A value that can provide an icon for display.
public protocol IconItem {
  var icon: IconLiteral { get }
}

extension LabeledItem where Self: NamedItem, Self: RawRepresentable, Self.RawValue == String {
  /// A label derived from ``NamedItem/name``.
  public var label: QuickLabel { .init(name) }
}

extension LabeledItem where Self: NamedItem & IconItem {
  /// A label derived from ``NamedItem/name`` and ``IconItem/icon``.
  public var label: QuickLabel { .init(name, icon: icon) }
}
