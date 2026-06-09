//
//  File.swift
//
//
//  Created by Dave Coleman on 27/5/2024.
//

import CoreTools
import SwiftUI

public struct StateView<Content: View, Message: View>: View {
  @Environment(\.layoutType) private var layoutType
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.layoutPadding) private var layoutPadding
  @Environment(\.isCompactMode) private var isCompact
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.controlSize) private var controlSize

  let label: QuickLabel
  let message: String?
  let messageContent: Message
  let additionalContent: Content

  public var body: some View {

    ContentUnavailableView {
//      MaybeLabel(label: label)
      TitleAndIconView(
        label: label,
        hasMessage: message != nil,
        iconSize: iconSize,
      )

    } description: {
      if let message {
        messageContent
//        Text(message)
          
      }
    } actions: {
      additionalContent
    }

    //    VStack {
    //      TitleAndIconView()
    //        /// Padding to achieve nice vertical optical centering
    //        .safeAreaPadding(.top, paddingLength)
    //
    //      MessageView()
    //      additionalContent
    //    }
    //    .monospacedDigit()
    //    .frame(maxWidth: 380)
    //    .padding(layoutPadding ?? Styles.sizeRegular)
  }
}

extension StateView {

  private var paddingLength: CGFloat {
    let hasIcon: Bool = label.icon != nil
    let isHstack: Bool = layoutType.isHstack
    return hasIcon && !isHstack ? controlSize.scale(iconSize * 1.4) : .zero
  }

  private var iconSize: CGFloat {
    let baseIconSize: CGFloat = 46
    return iconFontSize ?? baseIconSize
  }

  @ViewBuilder
  private func MessageView() -> some View {
    if let message = message {
      Text(message.toMarkdownCompatible)
        .multilineTextAlignment(.center)
        .font(.system(controlSize.textStyle))
        .foregroundStyle(.secondary.opacity(0.8))
        .padding(.bottom, controlSize.scale(16))
    }
  }
}

// MARK: - Initialisers
extension StateView {

  public init(
    _ title: String,
    message: String? = nil,
    @ViewBuilder messageContent: () -> Message = { EmptyView() },
    @ViewBuilder additionalContent: () -> Content = { EmptyView() },
  ) {
//  ) where Message == EmptyView, Content == EmptyView {
    self.label = QuickLabel(title)
    self.message = message
    self.messageContent = messageContent()
    self.additionalContent = additionalContent()
  }

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
    @ViewBuilder messageContent: () -> Message = { EmptyView() },
    @ViewBuilder additionalContent: () -> Content = { EmptyView() },
  ) {
//  ) where Message == EmptyView, Content == EmptyView {
    self.label = QuickLabel(title, icon: icon)
    self.message = message
    self.messageContent = messageContent()
    self.additionalContent = additionalContent()
  }

  public init(
    label: QuickLabel,
    message: String? = nil,
    @ViewBuilder messageContent: () -> Message = { EmptyView() },
    @ViewBuilder additionalContent: () -> Content = { EmptyView() },
  ) {
//  ) where Message == EmptyView, Content == EmptyView {
    self.label = label
    self.message = message
    self.messageContent = messageContent()
    self.additionalContent = additionalContent()
  }

}
