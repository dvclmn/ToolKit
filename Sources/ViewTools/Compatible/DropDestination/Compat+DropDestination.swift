//
//  Compat+DropDestination.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import Foundation
import SwiftUI

extension View {
  @ViewBuilder public func dropDestinationCompatible<T>(
    for type: T.Type = T.self,
    isEnabled: Bool = true,
    action: @escaping (
      _ items: [T],
      _ session: DropSessionCompatible
    ) -> Void,
  ) -> some View where T: Transferable {
    if #available(macOS 26, iOS 26, *) {
      dropDestination(
        for: type,
        isEnabled: isEnabled
      ) { items, session in
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
        isTargeted: { isTargeted in
          action(
            [],
            DropSessionCompatible(
              phase: isTargeted ? .entering : .exiting,
              itemsCount: nil,
              location: .zero,
            ),
          )
        },
      )
    } else {
      self
    }
  }
}
