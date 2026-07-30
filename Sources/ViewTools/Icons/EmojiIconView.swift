//
//  EmojiIconView.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/6/2026.
//

import SwiftUI

struct EmojiIconView: View {
  @Environment(\.font) var font
//  @Environment(\.isLabelStacked) var isLabelStacked

  let emoji: String

  var body: some View {

    Image(systemName: "eye")
      .hidden()
      .overlay {
        Text(emoji)
          .font(effectiveFont)
      }
  }
}

extension EmojiIconView {
  private var effectiveFont: Font? {
    font
//    isLabelStacked ? .system(size: 44) : font
  }
  //  private var scale: CGFloat { isLabelStacked ? 1.5 : 1 }
}
