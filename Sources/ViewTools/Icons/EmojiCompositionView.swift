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

  public init(composition: EmojiComposition) {
    self.composition = composition
  }

  public var body: some View {

    Text(baseCharacter)
      .hidden()
      .overlay {
        EmojiCompositionLayout {
          ForEach(composition.emoji) { emoji in
            Text(emoji.character.toString)
              .layoutValue(key: EmojiGlyphOffsetKey.self, value: emoji.offset)
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

private struct EmojiCompositionLayout: Layout {
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) -> CGSize {
    let intrinsicSize = subviews.reduce(into: CGSize.zero) { size, subview in
      let subviewSize = subview.sizeThatFits(.unspecified)
      size.width = max(size.width, subviewSize.width)
      size.height = max(size.height, subviewSize.height)
    }

    return CGSize(
      width: proposal.width ?? intrinsicSize.width,
      height: proposal.height ?? intrinsicSize.height,
    )
  }

  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) {
    let centre = CGPoint(x: bounds.midX, y: bounds.midY)

    for subview in subviews {
      let unitOffset = subview[EmojiGlyphOffsetKey.self]
      let offset = unitOffset.offset(in: bounds.size)
      let position = CGPoint(
        x: centre.x + offset.width,
        y: centre.y + offset.height,
      )

      subview.place(
        at: position,
        anchor: .center,
        proposal: .unspecified,
      )
    }
  }
}

private struct EmojiGlyphOffsetKey: LayoutValueKey {
  static let defaultValue = UnitOffset.zero
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
