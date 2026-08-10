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
  @Environment(\.controlSize) private var controlSize

  let label: LabelDescriptor
  let message: String?
  let isMessageCopyable: Bool
  let actions: Actions

  public var body: some View {

    ContentUnavailableView {
      QuickLabel(label)
    } description: {
      if let message {
        if isMessageCopyable {
          MessageView(message)
            // Text selection is enough for now
            .textSelection(.enabled)

        } else {
          MessageView(message)
        }
      }
    } actions: {
      actions
    }

  }
}

extension StateView {
  @ViewBuilder
  private func MessageView(_ message: String) -> some View {
    Text(LocalizedStringKey(message))
      .multilineTextAlignment(.center)
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
