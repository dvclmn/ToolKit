//
//  EmojiCompositionLayout.swift
//  ToolKit
//
//  Created by Dave Coleman on 14/6/2026.
//

import CoreTools
import SwiftUI

struct EmojiCompositionLayout: Layout {
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
      let unitOffset = subview[EmojiComposition.OffsetKey.self]
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

extension EmojiComposition {
  struct OffsetKey: LayoutValueKey {
    static let defaultValue = UnitOffset.zero
  }
  
}
