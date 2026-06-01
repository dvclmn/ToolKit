//
//  PersistenceKeyRegistry.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/4/2026.
//

/// A development-time registry for detecting duplicate persistence keys.
///
/// Register key types at app launch to assert that no two key declarations use
/// the same storage string.
@MainActor
public enum PersistenceKeyRegistry: Sendable {
  private static var registeredKeys: Set<String> = []
  
  /// Registers a key type and asserts if its storage key has already been registered.
  public static func register<K: PersistenceKey>(_ keyType: K.Type) {
    let key = K.storageKey
    assert(
      !registeredKeys.contains(key),
      "Duplicate persistence key: '\(key)' already registered",
    )
    registeredKeys.insert(key)
  }
  
}
