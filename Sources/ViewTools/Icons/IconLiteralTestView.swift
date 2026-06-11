//
//  IconLiteralTestView.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/6/2026.
//

import CoreTools
import SwiftUI

public struct IconLiteralTestView: View {

  private let examples: [IconLiteralTestItem] = [
    .init(
      title: "Emoji",
      icon: .emoji("🎨"),
      reference: #".emoji("🎨")"#,
    ),
    .init(
      title: "Emoji composition",
      icon: .emojiComposition(.example),
      reference: ".emojiComposition(…)",
    ),
    .init(
      title: "SF Symbol",
      icon: .preset(.),
      reference: #".symbol("paintpalette")"#,
    ),
    .init(
      title: "Custom symbol",
      icon: .customSymbol(.artboard),
      reference: ".customSymbol(.artboard)",
    ),
  ]

  public init() {}

  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Icon literals")
        .font(.headline)

      HStack(alignment: .top, spacing: 16) {
        ForEach(examples) { example in
          IconLiteralTestTile(example)
        }
      }
    }
    .padding()
  }
}

private struct IconLiteralTestItem: Identifiable {
  let id: String
  let title: String
  let icon: IconLiteral
  let reference: String

  init(
    title: String,
    icon: IconLiteral,
    reference: String,
  ) {
    self.id = title
    self.title = title
    self.icon = icon
    self.reference = reference
  }
}

private struct IconLiteralTestTile: View {

  let example: IconLiteralTestItem

  init(_ example: IconLiteralTestItem) {
    self.example = example
  }

  var body: some View {
    VStack(spacing: 8) {
      IconView(example.icon)
        .font(.system(size: 42))
        .symbolRenderingMode(.hierarchical)
        .frame(width: 56, height: 56)

      Text(example.title)
        .font(.callout)

      Text(example.reference)
        .font(.system(.caption, design: .monospaced))
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .lineLimit(3)
        .frame(width: 150)
    }
  }
}

#Preview("Icon literals") {
  IconLiteralTestView()
}
