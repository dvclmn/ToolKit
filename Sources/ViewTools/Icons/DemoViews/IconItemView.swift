//
//  IconItemView.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/6/2026.
//

import SwiftUI

struct IconLiteralTestTile: View {
  
  let example: IconLiteralExample
  
  init(_ example: IconLiteralExample) {
    self.example = example
  }
  
  var body: some View {
    VStack(spacing: 8) {
      IconView(example.icon)
        .font(.system(size: 42))
        .symbolRenderingMode(.hierarchical)
        .frame(width: 56, height: 56)
      
      Text(example.title)
        .font(.callout)
      
      Text(example.reference)
        .font(.system(.caption, design: .monospaced))
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .lineLimit(3)
        .frame(width: 150)
    }
  }
}
