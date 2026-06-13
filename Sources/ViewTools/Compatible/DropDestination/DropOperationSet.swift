//
//  DropOperationSet.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

public struct DropOperationSetCompatible: OptionSet, Sendable, Hashable, Equatable {
  public let rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  public static let cancel = Self(rawValue: 1 << 0)
  public static let copy = Self(rawValue: 1 << 1)
  public static let move = Self(rawValue: 1 << 2)
  public static let forbidden = Self(rawValue: 1 << 3)
  public static let delete = Self(rawValue: 1 << 4)
  public static let alias = Self(rawValue: 1 << 5)
  
  /// A human-readable name for the set of drop operations.
  /// For multiple operations, names are joined by a comma.
  /// Returns "None" when the set is empty.
  public var displayName: String {
    if isEmpty { return "None" }
    var parts: [String] = []
    if contains(.cancel) { parts.append("Cancel") }
    if contains(.copy) { parts.append("Copy") }
    if contains(.move) { parts.append("Move") }
    if contains(.forbidden) { parts.append("Forbidden") }
#if os(macOS)
    if contains(.delete) { parts.append("Delete") }
    if contains(.alias) { parts.append("Alias") }
#endif
    return parts.joined(separator: ", ")
  }
}

@available(iOS 26, macOS 26, *)
extension DropOperationSetCompatible {
  public init(_ operations: DropOperation.Set) {
    var result: Self = []
    
    if operations.contains(.cancel) {
      result.insert(.cancel)
    }
    if operations.contains(.copy) {
      result.insert(.copy)
    }
    if operations.contains(.move) {
      result.insert(.move)
    }
    if operations.contains(.forbidden) {
      result.insert(.forbidden)
    }
#if os(macOS)
    if operations.contains(.delete) {
      result.insert(.delete)
    }
    if operations.contains(.alias) {
      result.insert(.alias)
    }
#endif
    
    self = result
  }
}
