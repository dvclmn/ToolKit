//
//  OpticalCentreModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/6/2026.
//

import SwiftUI

struct OpticalCentreModifier: ViewModifier {

  let adjustmentStrength: CGFloat

  func body(content: Content) -> some View {
    OpticalCentreLayout(strength: adjustmentStrength) {
      content
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
extension View {
  /// Places this view in a full-size container, shifting it slightly above
  /// geometric centre when there is vertical room to do so.
  ///
  /// A strength of `1` uses the default optical centre adjustment. Use `0` for
  /// geometric centring, larger values for a stronger upward shift, and negative
  /// values to shift below centre.
  public func centreOptically(_ strength: CGFloat = 1) -> some View {
    self.modifier(OpticalCentreModifier(adjustmentStrength: strength))
  }
}

private struct OpticalCentreLayout: Layout {
  private static let defaultOffsetRatio: CGFloat = 0.06

  let strength: CGFloat

  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) -> CGSize {
    guard let subview = subviews.first else {
      return proposal.replacingUnspecifiedDimensions()
    }

    let subviewSize = subview.sizeThatFits(proposal)

    return CGSize(
      width: proposal.width ?? subviewSize.width,
      height: proposal.height ?? subviewSize.height,
    )
  }

  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) {
    guard let subview = subviews.first else { return }

    let subviewProposal = ProposedViewSize(
      width: bounds.width,
      height: bounds.height,
    )

    let subviewSize = subview.sizeThatFits(subviewProposal)
    let verticalSlack = max(0, bounds.height - subviewSize.height)
    let opticalOffset = verticalSlack * Self.defaultOffsetRatio * strength

    subview.place(
      at: CGPoint(
        x: bounds.midX,
        y: bounds.midY - opticalOffset,
      ),
      anchor: .center,
      proposal: subviewProposal,
    )
  }
}
