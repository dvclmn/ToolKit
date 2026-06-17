//
//  ErrorView.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/6/2026.
//

import CoreTools
import SwiftUI

public struct ErrorView<Actions: View>: View {

  let error: ErrorMessage
  let actions: Actions

  public init(
    error: ErrorMessage,
    @ViewBuilder actions: @escaping () -> Actions = { EmptyView() },
  ) {
    self.error = error
    self.actions = actions()
  }

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String,
    @ViewBuilder actions: () -> Actions = { EmptyView() },
  ) {
    self.error = ErrorMessage(title, icon: icon, message: message)
    self.actions = actions()
  }

  public var body: some View {

    ContentUnavailableView {
      QuickLabel(error.label)
        // Allows other views to respond appropriately to a stacked layout
        .environment(\.isLabelStacked, true)
      
    } description: {
      CopyableText(error.message.toLocalisedStringKey)
        
    } actions: {
      actions
    }
  }
}

#Preview(traits: .size(.normal)) {
  ErrorView(
    "Error finding file",
    icon: .emoji("☔️"),
    message: "Oh dear, I *can't* find that `file`.",
  )
}
