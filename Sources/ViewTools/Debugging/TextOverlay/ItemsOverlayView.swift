//
//  ItemsOverlayView.swift
//  ToolKit
//
//  Created by Dave Coleman on 19/4/2026.
//

import SwiftUI

struct DebugItemsOverlayView: View {
  let store: DebugItemStore
  let alignment: Alignment
  let isMonospaced: Bool

  var body: some View {

    if !store.items.isEmpty {

      ScrollView {

        VStack(alignment: .leading, spacing: 2) {
          //                  VStack(alignment: alignment.horizontal, spacing: 2) {
          ForEach(store.items) { item in
            Text(item.text)
              .font(.caption)
              .monospaced(isMonospaced)
          }
        }
        .padding(Styles.sizeSmall)
        .quickBackground(glass: .regular)
        .padding()
      }
      .scrollIndicators(.hidden)
      .defaultScrollAnchorCompatible(alignment.toUnitPoint(fallback: .center), for: .alignment)
      .frame(maxWidth: 480)
      //      .border(Color.green.opacity(0.3))
      //      .scrollContentBackground(.hidden)
      //      .scrollDisabled(true)
      //      .allowsHitTesting(false)

    } else {
      Text("No debug items")
    }

  }
}
