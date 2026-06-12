//
//  DropSession+ID.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

extension DropSessionCompatible {
  public struct ID: Hashable {
    private let value: AnyHashable
    #if canImport(AppKit)
    private let matchesDragInfo: ((any NSDraggingInfo) -> Bool)?
    #endif

    public init() {
      self.value = AnyHashable(UUID())
      #if canImport(AppKit)
      self.matchesDragInfo = nil
      #endif
    }

    @available(iOS 26, macOS 26, *)
    public init(_ id: DropSession.ID) {
      self.value = AnyHashable(id)
      #if canImport(AppKit)
      self.matchesDragInfo = { dragInfo in
        id.matches(dragInfo)
      }
      #endif
    }

    #if canImport(AppKit)
    public func matches(_ dragInfo: any NSDraggingInfo) -> Bool {
      matchesDragInfo?(dragInfo) ?? false
    }
    #endif

    public static func == (lhs: Self, rhs: Self) -> Bool {
      lhs.value == rhs.value
    }

    public func hash(into hasher: inout Hasher) {
      value.hash(into: &hasher)
    }
  }
}
