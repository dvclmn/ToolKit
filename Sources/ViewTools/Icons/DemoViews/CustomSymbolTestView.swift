//
//  CustomSymbolTestView.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/6/2026.
//

import CoreTools
import SwiftUI

public struct CustomSymbolTestView: View {

  public init() {}

  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Custom symbols")
        .font(.headline)

      VStack(alignment: .leading, spacing: 10) {
        ForEach(CustomSymbol.allCases) { symbol in
          CustomSymbolItemView(symbol)
        }
      }
    }
    .padding()
  }
}


#Preview("Custom symbols") {
  CustomSymbolTestView()
}
