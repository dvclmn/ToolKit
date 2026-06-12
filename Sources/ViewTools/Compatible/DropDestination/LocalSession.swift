//
//  LocalSession.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

private protocol DropSessionCompatibleLocalSessionStorage {
  func draggedItemIDs<ItemID>(
    for type: ItemID.Type
  ) -> [ItemID] where ItemID: Hashable
}

@available(iOS 26, macOS 26, *)
private struct NativeDropSessionCompatibleLocalSessionStorage:
  DropSessionCompatibleLocalSessionStorage
{
  let session: DropSession.LocalSession

  func draggedItemIDs<ItemID>(
    for type: ItemID.Type
  ) -> [ItemID] where ItemID: Hashable {
    session.draggedItemIDs(for: type)
  }
}

extension DropSessionCompatible {
  public struct LocalSession {
    private let storage: any DropSessionCompatibleLocalSessionStorage

    @available(iOS 26, macOS 26, *)
    public init(_ session: DropSession.LocalSession) {
      self.storage = NativeDropSessionCompatibleLocalSessionStorage(session: session)
    }

    public func draggedItemIDs<ItemID>(
      for type: ItemID.Type
    ) -> [ItemID] where ItemID: Hashable {
      storage.draggedItemIDs(for: type)
    }
  }
}
