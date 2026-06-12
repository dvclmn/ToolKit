//
//  Compat+DropDestination.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

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
    action: @escaping (_ items: [T], _ session: DropSession) -> Void
  ) -> some View where T : Transferable {
    if #available(macOS 26, iOS 26, *) {
      dropDestination(for: type, isEnabled: isEnabled, action: action)
    } else {
      dropDestination(for: type, action: <#T##([Transferable], CGPoint) -> Bool##([Transferable], CGPoint) -> Bool##(_ items: [Transferable], _ location: CGPoint) -> Bool#>, isTargeted: <#T##(Bool) -> Void#>)
    }
  }
}

// I started recreating the new DropSession and related types for backwards
// compat, but reconsidering

//public struct DropSessionCompatible: Identifiable, Sendable {
//  
//}
//
//extension DropSessionCompatible {
//  public struct LocalSessionCompatible: Sendable {
//    public func draggedItemIDs<ItemID>(for type: ItemID.Type) -> [ItemID] where ItemID : Hashable {
//      
//    }
//  }
//}
