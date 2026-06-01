//
//  ToggleKey.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

/// A typed declaration for a persisted value.
///
/// Use a concrete `PersistenceKey` type to centralise the storage key string and
/// default value for a piece of persisted state. See <doc:PersistenceKeys> for
/// usage examples.
public protocol PersistenceKey: Sendable {
  associatedtype Value: Sendable

  /// The storage key used by the persistence backend.
  ///
  /// Prefer stable, namespaced keys such as `breathingWaves.shaders.enabled`.
  static var storageKey: String { get }

  /// The value to use when no persisted value exists.
  static var defaultValue: Value { get }
}
