//
//  IconLiteralExample.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/6/2026.
//

import CoreTools

struct IconLiteralExample: Identifiable {
  var id: String { title }
  let title: String
  let icon: IconLiteral
  let reference: String
  
  init(
    title: String,
    icon: IconLiteral,
    reference: String,
  ) {
    self.title = title
    self.icon = icon
    self.reference = reference
  }
}

extension IconLiteralExample {
  
  static let examples: [IconLiteralExample] = [
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
      icon: .randomSymbol,
      reference: #".symbol("paintpalette")"#,
    ),
    .init(
      title: "Custom symbol",
      icon: .customSymbol(.artboard),
      reference: ".customSymbol(.artboard)",
    ),
  ]

}
