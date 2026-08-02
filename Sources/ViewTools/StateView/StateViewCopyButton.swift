//
//  StateViewCopyButton.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/8/2026.
//

import SwiftUI

/// Keeps the message centred when its natural width and the copy button fit on
/// one line. Otherwise, the button moves beneath the wrapped message.
struct CopyableMessageLayout: Layout {
  private let spacing: CGFloat = 8

  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) -> CGSize {
    guard subviews.count == 2 else {
      return proposal.replacingUnspecifiedDimensions()
    }

    let message = subviews[0]
    let copyButton = subviews[1]
    let horizontalSize = horizontalSize(message: message, copyButton: copyButton)
    let width = proposal.width ?? horizontalSize.width

    if width >= horizontalSize.width {
      return CGSize(width: width, height: horizontalSize.height)
    }

    let messageSize = message.sizeThatFits(
      ProposedViewSize(width: width, height: nil)
    )
    let buttonSize = copyButton.sizeThatFits(.unspecified)

    return CGSize(
      width: width,
      height: messageSize.height + spacing + buttonSize.height,
    )
  }

  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Void,
  ) {
    guard subviews.count == 2 else { return }

    let message = subviews[0]
    let copyButton = subviews[1]
    let horizontalSize = horizontalSize(message: message, copyButton: copyButton)

    if bounds.width >= horizontalSize.width {
      let messageSize = message.sizeThatFits(.unspecified)

      message.place(
        at: CGPoint(x: bounds.midX, y: bounds.midY),
        anchor: .center,
        proposal: .unspecified,
      )
      copyButton.place(
        at: CGPoint(x: bounds.midX + (messageSize.width / 2) + spacing, y: bounds.midY),
        anchor: .leading,
        proposal: .unspecified,
      )

    } else {
      let messageProposal = ProposedViewSize(width: bounds.width, height: nil)
      let messageSize = message.sizeThatFits(messageProposal)

      message.place(
        at: CGPoint(x: bounds.midX, y: bounds.minY),
        anchor: .top,
        proposal: messageProposal,
      )
      copyButton.place(
        at: CGPoint(x: bounds.midX, y: bounds.minY + messageSize.height + spacing),
        anchor: .top,
        proposal: .unspecified,
      )
    }
  }
}

extension CopyableMessageLayout {

  private func horizontalSize(
    message: LayoutSubview,
    copyButton: LayoutSubview,
  ) -> CGSize {
    let messageSize = message.sizeThatFits(.unspecified)
    let buttonSize = copyButton.sizeThatFits(.unspecified)

    return CGSize(
      width: messageSize.width + spacing + buttonSize.width,
      height: max(messageSize.height, buttonSize.height),
    )
  }
}
