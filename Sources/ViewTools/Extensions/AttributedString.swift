//
//  AttributedString.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

 import SwiftUI

extension AttributedString {
  public func monospaced(_ font: Font? = nil) -> AttributedString {
    self.transformingAttributes(\.font) { attr in
      attr.value = font?.monospaced() ?? Font.body.monospaced()
    }
  }
  
  public mutating func quickHighlight() {
    let highlightContainer: AttributeContainer = .colours(.black, on: .green)
    self.setAttributes(highlightContainer)
  }
}
