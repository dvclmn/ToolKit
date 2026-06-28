//
//  CopyableText.swift
//  ToolKit
//
//  Created by Dave Coleman on 17/6/2026.
//

import CoreTools
import StringTools
import SwiftUI

struct CopyableText: View {

  @State private var copied: Bool = false
  let text: LocalizedStringResource
  //  let text: LocalizedStringKey

  public init(_ key: LocalizedStringResource) {
    self.text = key
  }

  var body: some View {
    HStack(alignment: .lastTextBaseline) {
      Text(text)

      Button {
        copyStringToClipboard(String(localized: text))
        copied = true
      } label: {
        Label {
          Text("Copy Text")
        } icon: {
          Image(systemName: Icons.copy.icon)
            .opacity(copied ? 0 : 1)
            .overlay {
              if copied {
                Image(systemName: Icons.tick.icon)
                  .transition(.symbolEffect(.appear))
              }
            }
        }

        //        Label("Copy Text", systemImage: Icons.copy.icon)
        .labelStyle(.iconOnly)
        .foregroundStyle(.secondary)

        .fontWeight(.medium)

      }
      .buttonStyle(.plain)
      .help("Copy text to clipboard")

      .onHoldDelay(
        of: copied,
        equals: true,
        delay: .seconds(2),
      ) {
        self.copied = false
      }

      //      .task(id: copied) {
      //        if copied {
      //          do {
      //            await Task.sleep(for: .seconds(1))
      //          }
      //        }
      //      }
    }
  }
}
