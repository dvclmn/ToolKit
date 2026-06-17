//
//  CopyableText.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/6/2026.
//

import SwiftUI

struct CopyableText: View {

  @State private var copied: Bool = false
  let text: LocalizedStringKey

  public init(_ key: LocalizedStringKey) {
    self.text = key
  }

  var body: some View {
    HStack(alignment: .lastTextBaseline) {
      Text(text)

      Button {
        copyStringToClipboard("\(text)")
        copied = true
      } label: {
        Label("Copy Text", systemImage: Icons.copy.icon)
          .labelStyle(.iconOnly)
          .foregroundStyle(.secondary)
          .fontWeight(.medium)
      }
      .buttonStyle(.plain)
      .help("Copy text to clipboard")
    }
  }
}
