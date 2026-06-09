//
//  ErrorView.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/6/2026.
//

import CoreTools
import SwiftUI

public struct ErrorView<Content: View>: View {

  let error: ErrorMessage
  let additionalContent: Content

  public init(
    error: ErrorMessage,
    @ViewBuilder additionalContent: @escaping () -> Content,
  ) {
    self.error = error
    self.additionalContent = additionalContent()
  }
  
  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String,
    @ViewBuilder additionalContent: () -> Content = { EmptyView() },
  ) {
    self.error = ErrorMessage(title, icon: icon, message: message)
    self.additionalContent = additionalContent()
  }

  public var body: some View {
    StateView(
      label: error.label,
      message: error.message,
      additionalContent: additionalContent,
    )

  }
}

extension ErrorView {

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
