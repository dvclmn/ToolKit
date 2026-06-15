//
//  IconView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/9/2025.
//

import CoreTools
import SwiftUI

struct IconView: View {

  let icon: IconLiteral

  public init(_ icon: IconLiteral) {
    self.icon = icon
  }

  public var body: some View {
    switch icon {
      case .emoji(let emojiString): EmojiIconView(emoji: emojiString)
      case .emojiComposition(let comp): EmojiCompositionView(comp)
      case .symbol(let symbolString): Image(systemName: symbolString)
      case .customSymbol(let customSymbol):
        Image(customSymbol.reference, bundle: .module)
    }
  }
}
