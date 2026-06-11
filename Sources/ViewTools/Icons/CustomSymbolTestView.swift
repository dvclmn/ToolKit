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
          CustomSymbolTestRow(symbol)
        }
      }
    }
    .padding()
  }
}

private struct CustomSymbolTestRow: View {

  let symbol: CustomSymbol

  init(_ symbol: CustomSymbol) {
    self.symbol = symbol
  }

  var body: some View {
    HStack(spacing: 12) {
      
      IconView(.customSymbol(symbol))
        .frame(width: 28, height: 28)

      Image(symbol.reference, bundle: .module)
        .frame(width: 28, height: 28)

      Text(symbol.reference)
        .font(.system(.body, design: .monospaced))
    }
    .font(.system(size: 22))
    .symbolRenderingMode(.hierarchical)
  }
}

#Preview("Custom symbols") {
  CustomSymbolTestView()
}
