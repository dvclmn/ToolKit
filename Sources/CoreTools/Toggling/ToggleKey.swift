//
//  TogglePersistenceKey.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/4/2026.
//

import Foundation

/// A persistence key specialised for boolean toggle state.
public protocol ToggleKey: PersistenceKey where Value == Bool {

  static var displayName: String { get }
  static var kind: ToggleKind { get }
}

extension ToggleKey {

  public static var defaultValue: Bool { true }

  /// Builds a storage key in the form `{domain}.{section}{KindSuffix}`.
  public static func key(
    from domain: String,
    _ section: String,
  ) -> String {
    "\(domain).\(section)\(kind.camelSuffix)"
  }

  /// A display name derived from ``PersistenceKey/storageKey`` by removing the
  /// toggle kind suffix and splitting camel case.
  ///
  /// For example, `breathingWaves.lineStyleExpanded` becomes `Line Style`.
  public static var displayName: String {
    let last = storageKey.split(separator: ".").last.map(String.init) ?? storageKey
    let section =
      last.hasSuffix(kind.camelSuffix)
      ? String(last.dropLast(kind.camelSuffix.count))
      : last

    return section.splitCamelCase().capitalisingFirstLetter()
  }
}

extension String {
  fileprivate func splitCamelCase() -> String {
    var out = ""
    out.reserveCapacity(count + 8)

    var prevWasLower = false
    for scalar in unicodeScalars {
      let isUpper = CharacterSet.uppercaseLetters.contains(scalar)
      if isUpper, prevWasLower { out.append(" ") }
      out.append(Character(scalar))
      prevWasLower = CharacterSet.lowercaseLetters.contains(scalar)
    }
    return out
  }

  fileprivate func capitalisingFirstLetter() -> String {
    guard let first else { return self }
    return String(first).uppercased() + dropFirst()
  }
}
