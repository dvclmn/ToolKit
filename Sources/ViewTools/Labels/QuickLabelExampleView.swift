//
//  QuickLabelExampleView.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/6/2026.
//

import SwiftUI

struct QuickLabelExampleView: View {

  var body: some View {

    VStack {
      
      VStack(alignment: .leading) {
        LabelGroup()
      }
      .debugFrame("Left-aligned VStack", .brown)
      
      List {
        LabelGroup()
      }
      .frame(maxWidth: 500)
      .debugFrame("List", .yellow)
    }
  }
}

extension QuickLabelExampleView {
  @ViewBuilder
  private func LabelGroup() -> some View {
//    Group {
//    VStack(alignment: .leading) {
      QuickLabel("I'm an Emoji", icon: .emoji("⛱️"))
      QuickLabel("Simple SF Symbol", icon: .randomSymbol)
      QuickLabel("Emoji Composition", icon: .emojiComposition(.example))
      QuickLabel("Custom Symbols", icon: .customSymbol(.terminal))
//    }
//    .border(Color.green.opacity(0.3))
  }
}

#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  QuickLabelExampleView()
  // .environment(store)
}
