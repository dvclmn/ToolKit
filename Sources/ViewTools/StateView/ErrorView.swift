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
//      Label("Hello", systemImage: "binoculars")
      MaybeLabel(error.label)
    } description: {
      Text(error.message)
    } actions: {
      actions
    }

//    StateView(
////    StateView<Content, EmptyView>(
//      label: error.label,
//      message: error.message,
//      isMessageCopyable: true,
//      actions: actions,
//    )

  }
}

#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  ErrorView(
    "Error finding file",
    icon: .emoji("☔️"),
    message: "Oh dear, I can't find that file."
  )
  // .environment(store)
}
