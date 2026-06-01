//
//  GlobalUtility.swift
//  ToolKit
//
//  Created by Dave Coleman on 14/6/2025.
//

import Foundation

/// Updates `target` only when it differs from `newValue`.
///
/// - Returns: `true` when the value changed.
@discardableResult
public func updateIfChanged<T: Equatable>(
  _ target: inout T,
  to newValue: T,
) -> Bool {
  guard target != newValue else { return false }
  target = newValue
  return true
}

/// Updates an optional `target` only when it differs from `newValue`.
///
/// - Returns: `true` when the value changed.
@discardableResult
public func updateIfChanged<T: Equatable>(
  _ target: inout T?,
  to newValue: T,
) -> Bool {
  guard target != newValue else { return false }
  target = newValue
  return true
}

/// Assigns `newValue` only when `target` is currently `nil`.
///
/// - Returns: `true` when the value was assigned.
@discardableResult
public func updateIfNil<T: Equatable>(
  _ target: inout T?,
  to newValue: T,
) -> Bool {
  if target == nil {
    target = newValue
    return true
  }
  return false
}

/// Performs `perform` only when `oldValue` and `newValue` differ.
///
/// - Returns: `true` when the action ran.
@discardableResult
public func performIfChanged<T: Equatable>(
  _ oldValue: T,
  _ newValue: T,
  perform: @autoclosure () -> Void,
) -> Bool {
  guard oldValue != newValue else { return false }
  perform()
  return true
}

/// Updates a writable key-path value only when it differs from `newValue`.
///
/// - Returns: `true` when the value changed.
@discardableResult
public func updateIfChanged<Root, Value: Equatable>(
  _ object: inout Root,
  at keyPath: WritableKeyPath<Root, Value>,
  to newValue: Value,
) -> Bool {
  guard object[keyPath: keyPath] != newValue else { return false }
  object[keyPath: keyPath] = newValue
  return true
}

/// Updates an optional writable key-path value only when it differs from `newValue`.
///
/// - Returns: `true` when the value changed.
@discardableResult
public func updateIfChanged<Root, Value: Equatable>(
  _ object: inout Root,
  at keyPath: WritableKeyPath<Root, Value?>,
  to newValue: Value,
) -> Bool {
  guard object[keyPath: keyPath] != newValue else { return false }
  object[keyPath: keyPath] = newValue
  return true
}

/// Updates a key-path value on an optional root only when it differs from `newValue`.
///
/// - Returns: `true` when the value changed.
@discardableResult
public func updateIfChangedWithOptionalRoot<Root, Value: Equatable>(
  _ newValue: Value,
  on object: inout Root?,
  keyPath: WritableKeyPath<Root, Value>,
) -> Bool {
  guard object?[keyPath: keyPath] != newValue else { return false }
  object?[keyPath: keyPath] = newValue
  return true
}
