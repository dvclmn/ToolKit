//
//  TitleAndIconView.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/6/2026.
//

import CoreTools
import SwiftUI

struct TitleAndIconView: View {
  @Environment(\.layoutType) private var layoutType
  @Environment(\.controlSize) private var controlSize

  let label: QuickLabel
  let hasMessage: Bool
  let iconSize: CGFloat
  //  let message: String?

  var body: some View {

//    Group {
      switch layoutType {
        case .hstack:
          MaybeLabel(label)

        default:
          MaybeLabel(label: label)
//          Text(label.text.toMarkdownCompatible)
            /// Pan gesture view was causing `FeatureIconView` to take
            /// up too much space, so using overlay to keep it contained better
//            .overlay(alignment: .top) {
//              IconView()
//            }
      }
//    }  // END group
//    .multilineTextAlignment(.center)
//    .font(.system(controlSize.textStyle))
//    .foregroundStyle(effectiveTitleColour)

  }
}

extension TitleAndIconView {

  private func offsetAmount(_ icon: IconLiteral) -> CGFloat {
    icon.isEmojiComposition
      ? iconSize * 1.7
      : iconSize * 1.3
  }

  private var effectiveTitleColour: some ShapeStyle {
    let base: HierarchicalShapeStyle = .primary
    let opacity: CGFloat = hasMessage ? 0.9 : 0.85
    return base.opacity(opacity)
  }

  @ViewBuilder
  private func IconView() -> some View {
    if let icon = label.icon {
      FeatureIconView(icon: icon, fontSize: controlSize.scale(iconSize))
        .offset(y: -controlSize.scale(offsetAmount(icon)))
        .foregroundStyle(.secondary.opacity(0.86))
    }
  }
}
