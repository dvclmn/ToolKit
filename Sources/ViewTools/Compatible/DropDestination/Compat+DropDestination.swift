//
//  Compat+DropDestination.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import Foundation
import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// Older (deprecated) modifier for reference:
/// ```
/// nonisolated public func dropDestination<T>(for payloadType: T.Type = T.self, action: @escaping (_ items: [T], _ location: CGPoint) -> Bool, isTargeted: @escaping (Bool) -> Void = { _ in }) -> some View where T : Transferable
/// ```

/// New modifier for reference:
/// ```
/// nonisolated public func dropDestination<T>(
///   for type: T.Type = T.self,
///   isEnabled: Bool = true,
///   action: @escaping (_ items: [T], _ session: DropSession) -> Void
/// ) -> some View where T : Transferable
/// ```

extension View {
  @ViewBuilder public func dropDestinationCompatible<T>(
    for type: T.Type = T.self,
    isEnabled: Bool = true,
    action: @escaping (_ items: [T], _ session: DropSessionCompatible) -> Void,
  ) -> some View where T: Transferable {
    if #available(macOS 26, iOS 26, *) {
      dropDestination(for: type, isEnabled: isEnabled) { items, session in
        action(items, DropSessionCompatible(session))
      }
    } else if isEnabled {
      dropDestination(
        for: type,
        action: { items, location in
          action(
            items,
            DropSessionCompatible(
              phase: .dataTransferCompleted,
              itemsCount: items.count,
              location: location,
            ),
          )
          return true
        },
      )
    } else {
      self
    }
  }
}
