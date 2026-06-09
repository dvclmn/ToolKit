//
//  StateViewComparison.swift
//  ToolKit
//
//  Created by Dave Coleman on 19/5/2026.
//

import CoreTools
import SwiftUI

struct StateViewComparison: View {

  let size: ControlSize
  let title: String
  let icon: String
  let message: String
  let showsAddtionalContent: Bool
  var body: some View {

    GroupBox("ControlSize: " + size.displayName) {
      VStack(spacing: 30) {

        GroupBox("StateView") {
          StateView(
            title,
            icon: .symbol(icon),
            message: message,
          ) {
            if showsAddtionalContent {
              ExampleButton()
            }
          }
        }
        .groupBoxStyle(.prominent)

        GroupBox("ContentUnavailableView") {
          ContentUnavailableView {
            Label(title, systemImage: icon)
          } description: {
            Text(message)
          } actions: {
            if showsAddtionalContent {
              ExampleButton()
            }
          }
        }
        .groupBoxStyle(.base)
      }
      //      .border(Color.green.opacity(0.3))
    }
    //    .groupBoxStyle(.)
    //    .quickRoundedBackground()

  }
}

extension StateViewComparison {
  @ViewBuilder
  private func ExampleButton() -> some View {
    Button {

    } label: {
      Label("Example button", systemImage: "plus")
    }
  }
}
