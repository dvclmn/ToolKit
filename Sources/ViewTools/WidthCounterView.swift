//
//  WidthCounterView.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

struct WidthCounterView: View {
  
  var body: some View {
    
    VStack(spacing: 60) {
      Text(counter.widthCounter(style: .ruler))
      Text(counter.widthCounter(style: .digits))
    }
    .textSelection(.enabled)
    .monospaced()
    .frame(width: 400, height: 600)
    .background(.black.opacity(0.6))
  }
  private var counter: WidthCounter {
    WidthCounter(width: 38)
  }
}

#Preview {
  WidthCounterView()
}
