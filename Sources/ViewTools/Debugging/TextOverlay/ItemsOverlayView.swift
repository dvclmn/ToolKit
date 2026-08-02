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
  var body: some View {

    if !store.items.isEmpty {

      ScrollView {

        VStack(alignment: .leading, spacing: 2) {
//                  VStack(alignment: alignment.horizontal, spacing: 2) {
          ForEach(store.items) { item in
            Text(item.text)
              .font(.caption)
              .monospaced()
          }
        }
        .quickBackground(glass: .regular)
        .padding()
//        .background(.regularMaterial)
//        .clipShape(.rect(cornerRadius: 3))
//        .padding()
      }
      .scrollIndicators(.hidden)
      .defaultScrollAnchorCompatible(alignment.toUnitPoint(fallback: .center), for: .alignment)
      .border(Color.green.opacity(0.3))
      //      .scrollContentBackground(.hidden)
      //      .scrollDisabled(true)
      //      .allowsHitTesting(false)

    } else {
      Text("No debug items")
    }

  }
}
