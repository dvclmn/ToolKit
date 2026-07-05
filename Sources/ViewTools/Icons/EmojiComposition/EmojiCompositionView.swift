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

  let composition: EmojiComposition

  public init(_ composition: EmojiComposition) {
    self.composition = composition
  }

  public var body: some View {

    Image(systemName: "eye")
      .hidden()
      .overlay {
        EmojiCompositionLayout {
          ForEach(composition.emoji) { emoji in
            Text(emoji.character.toString)
              .layoutValue(
                key: EmojiComposition.OffsetKey.self,
                value: emoji.offset
              )
              .rotationEffect(.degrees(emoji.rotation))
              .scaleEffect(emoji.scale)
          }
        }
        //          .font(.system(size: 46))

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

#if DEBUG
#Preview {
  EmojiCompositionView(.example)
    .frame(width: 400, height: 600)
  //    .environment(\.isDebugMode, true)
  // .environment(store)
}
#endif
