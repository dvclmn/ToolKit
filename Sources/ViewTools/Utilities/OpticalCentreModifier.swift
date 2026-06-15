//
//  OpticalCentreModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/6/2026.
//

import SwiftUI

struct OpticalCentreModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity,
        alignment: .center
      )
  }
}
extension View {
  public func centreOptically() -> some View {
    self.modifier(OpticalCentreModifier())
  }
}
