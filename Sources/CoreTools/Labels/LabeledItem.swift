//
//  LabeledItem.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/5/2025.
//

import Foundation

/// A value that can provide a stable identifier and display label.
public protocol LabeledItem: Identifiable {
  var label: LabelDescriptor { get }
}

extension LabeledItem where Self: RawRepresentable, Self.RawValue == String {
  public var id: String { rawValue }

  /// A default label derived by capitalising the first character of `rawValue`.
  public var label: LabelDescriptor {
    let result = rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    return .init(result)
  }
}
