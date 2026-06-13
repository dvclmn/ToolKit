//
//  Pickable.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

/// A labeled item that can appear in a picker-style control.
public protocol Pickable: LabeledItem {

  /// A label that describes the purpose of the whole enum.
  ///
  /// For example, "View Mode" or "Inspector Tab".
  static var pickerLabel: LabelDescriptor { get }
}

extension Pickable where Self: CaseIterable, Self.AllCases == [Self] {
  public var allItems: [Self] { Self.allCases }
}
