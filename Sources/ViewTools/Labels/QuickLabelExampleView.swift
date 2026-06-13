//
//  QuickLabelExampleView.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/6/2026.
//

import SwiftUI

struct QuickLabelExampleView: View {

  private enum FontPreset: String, CaseIterable, Identifiable {
    case small = "Small"
    case body = "Body"
    case title = "Title"
    case largeTitle = "Large Title"
    case giant = "Giant"

    var id: String { rawValue }

    var font: Font {
      switch self {
        case .small: return .footnote
        case .body: return .body
        case .title: return .title
        case .largeTitle: return .largeTitle
        case .giant: return .system(size: 50)
      }
    }
  }

  @State private var selectedPreset: FontPreset = .body

  var body: some View {

    VStack(spacing: 40) {

      VStack(alignment: .leading) {
        LabelGroup()
      }
      .padding(.top)

      List {
        LabelGroup()
      }
      .frame(maxWidth: 500)

    }
    .font(selectedPreset.font)
    .safeAreaInset(edge: .top) {

      Picker("Font Size", selection: $selectedPreset) {
        ForEach(FontPreset.allCases) { preset in
          Text(preset.rawValue).tag(preset)
        }
      }
      .pickerStyle(.segmented)
      .padding()

    }
  }
}

extension QuickLabelExampleView {
  @ViewBuilder
  private func LabelGroup() -> some View {
    QuickLabel("I'm an Emoji", icon: .emoji("⛱️"))
    QuickLabel("Simple SF Symbol", icon: .randomSymbol)
    QuickLabel("Composition", icon: .emojiComposition(.example))
    QuickLabel("Custom Symbol", icon: .customSymbol(.terminal))
  }
}

#Preview(traits: .size(.normal)) {
  QuickLabelExampleView()
}
