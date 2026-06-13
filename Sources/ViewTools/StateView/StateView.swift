//
//  File.swift
//
//
//  Created by Dave Coleman on 27/5/2024.
//

import CoreTools
import SwiftUI

public struct StateView<Actions: View>: View {
  @Environment(\.layoutType) private var layoutType
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.layoutPadding) private var layoutPadding
  @Environment(\.isCompactMode) private var isCompact
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.controlSize) private var controlSize

  let label: LabelDescriptor
  let message: String?
  let isMessageCopyable: Bool
  let actions: Actions

  public var body: some View {

    ContentUnavailableView {
//      MaybeLabel(label: label)
      TitleAndIconView(
        label: label,
        hasMessage: message != nil,
        iconSize: iconSize,
      )
//      .environment(\.layoutType, .hstack())

    } description: {
      if let message {
//        messageContent
        HStack {
          Text(message)
          if isMessageCopyable {
            Button {
              
            } label: {
              Label("Copy", systemImage: Icons.copy.icon)
            }
          }
        }
          
      }
    } actions: {
      actions
    }
    

    //    VStack {
    //      TitleAndIconView()
    //        /// Padding to achieve nice vertical optical centering
    //        .safeAreaPadding(.top, paddingLength)
    //
    //      MessageView()
    //      actions
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
      Text(message)
//      Text(message.toMarkdownCompatible)
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
    isMessageCopyable: Bool = false,
    @ViewBuilder actions: () -> Actions = { EmptyView() },
  ) {
    self.label = LabelDescriptor(title)
    self.message = message
    self.isMessageCopyable = isMessageCopyable
    self.actions = actions()
  }

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
    isMessageCopyable: Bool = false,
    @ViewBuilder actions: () -> Actions = { EmptyView() },
  ) {
    self.label = LabelDescriptor(title, icon: icon)
    self.message = message
    self.isMessageCopyable = isMessageCopyable
    self.actions = actions()
  }

  public init(
    label: LabelDescriptor,
    message: String? = nil,
    isMessageCopyable: Bool = false,
    @ViewBuilder actions: () -> Actions = { EmptyView() },
  ) {
    self.label = label
    self.message = message
    self.isMessageCopyable = isMessageCopyable
    self.actions = actions()
  }
}
