//
//  EmojiCompositionView.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/2/2026.
//

import CoreTools
import SwiftUI

public struct EmojiCompositionView: View {
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.controlSize) private var controlSize

  let composition: EmojiComposition

  public init(composition: EmojiComposition) {
    self.composition = composition
  }

  public var body: some View {

    Text(baseCharacter)
      .hidden()
      .overlay {
        ForEach(composition.emoji) { emoji in
          Text(emoji.character.toString)
            .offset(emoji.offset.offset(in: <#T##CGSize#>))
//            .offset(x: emoji.offset.x, y: emoji.offset.y)
//            .offset(emoji.offset)
            .rotationEffect(.degrees(emoji.rotation))
            .scaleEffect(emoji.scale)
        }
        //          .font(.system(size: 46))
        //      .font(.system(size: controlSize.scale(fontSize)))

        //          if isDebugMode {
        //            Circle()
        //              .fill(.teal)
        //              .stroke(.blue, lineWidth: 1)
        //              .frame(width: 8, height: 8)
        //          }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      }

    //    .drawingGroup()
  }
}

extension EmojiCompositionView {
  private var baseCharacter: String { "A" }
  //  private var fontSize: CGFloat {
  //    20 * composition.scale
  //  }
}

#if DEBUG
#Preview {
  EmojiCompositionView(composition: .example)
    .frame(width: 400, height: 600)
  //    .environment(\.isDebugMode, true)
  // .environment(store)
}
#endif
