//
//  DebugTextModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/4/2026.
//

import SwiftUI

struct DebugTextOverlayModifier: ViewModifier {
  @Environment(DebugItemStore.self) private var inheritedStore: DebugItemStore?
  @State private var ownedStore = DebugItemStore()

  let isEnabled: Bool
  let edge: VerticalEdge
  var alignment: Alignment

  func body(content: Content) -> some View {
    content
      .environment(ownedStore)
    // TODO: Perhaps shouldn't assume that `safeAreaBarCompatible` is
    // always the right way to present the debug text
//      .safeAreaBarCompatible(
//        edge: edge,
//        alignment: alignment.horizontal,
//        spacing: nil,
//      ) {
      .overlay(alignment: .bottomLeading) {
        if isEnabled, !ownedStore.items.isEmpty {
          DebugItemsOverlayView(
            store: ownedStore,
            alignment: alignment,
          )
          .allowsHitTesting(false)

        }
      }
      //      .overlay(alignment: alignment) {

      //      }
      .overlay {
        if inheritedStore != nil {
          Text(
            "An instance of `DebugItemStore` already exists higher up in the view hierarchy. Ensure `debugTextOverlay(isEnabled:alignment:)` is used only once."
          )
          .background(Color.orange.tertiary)

        }
      }
    //    }
  }
}

extension DebugTextOverlayModifier {
  //  private var hasItems: Bool {
  //    guard let items = ownedStore.items
  //  }
}
