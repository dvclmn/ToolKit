//
//  CopyTextButton.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/8/2026.
//

import SwiftUI

// Popup disabled, as not available in ToolKit
public struct CopyTextButton: View {
  //  @Environment(\.popup) private var popup

  let title: String
  let contentToCopy: String

  public init(
    _ title: String = "Copy",
    content: String,
  ) {
    self.title = title
    self.contentToCopy = content
  }
  public var body: some View {

    Button {
      copyStringToClipboard(contentToCopy)
      //      popup?.showPopup(.make("Copied to clipboard", icon: .preset(.copyAlt)))

    } label: {
      Label(title, systemImage: Icons.copyAlt.icon)
        .symbolVariant(.fill)
    }
//    .buttonStyle(.base)

  }
}
