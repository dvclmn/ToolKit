//
//  CustomSymbolItemView.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import CoreTools
import SwiftUI

struct CustomSymbolItemView: View {

  let symbol: CustomSymbol

  init(_ symbol: CustomSymbol) {
    self.symbol = symbol
  }

  var body: some View {
    HStack(spacing: 12) {

      IconView(.customSymbol(symbol))
//        .frame(width: 28, height: 28)

      Text(symbol.reference)
        .font(.system(.body, design: .monospaced))
    }
    .font(.system(size: 22))
    .symbolRenderingMode(.hierarchical)
  }
}
