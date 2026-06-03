//
//  AttributeContainer+Presets.swift
//  StringTools
//
//  Created by Dave Coleman on 30/8/2024.
//

import Foundation

extension AttributeContainer {

  /// Converts the container to native text attributes for the requested scope.
  public func getAttributes<S: AttributeScope>(
    for scope: KeyPath<AttributeScopes, S.Type>
  ) -> NSTextAttributes? {
    do {
      return try Dictionary(self, including: scope)
    } catch {
      return nil
    }
  }

  #if canImport(UIKit)
  func getAttributes() -> NSTextAttributes? {
    return getAttributes(for: \.uiKit)
  }

  #elseif canImport(AppKit)
  func getAttributes() -> NSTextAttributes? {
    return getAttributes(for: \.appKit)
  }

  #endif

}
