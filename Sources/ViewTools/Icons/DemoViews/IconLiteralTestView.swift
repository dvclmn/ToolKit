//
//  IconLiteralTestView.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/6/2026.
//

import CoreTools
import SwiftUI

public struct IconLiteralTestView: View {

  public init() {}

  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Icon literals")
        .font(.headline)

      HStack(alignment: .top, spacing: 16) {
        ForEach(IconLiteralExample.examples) { example in
          IconLiteralTestTile(example)
        }
      }
    }
    .padding()
  }
}


#Preview("Icon literals") {
  IconLiteralTestView()
}
