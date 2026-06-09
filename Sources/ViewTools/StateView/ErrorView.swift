//
//  ErrorView.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/6/2026.
//

import SwiftUI
import CoreTools

struct ErrorView<Content: View>: View {
  
  let error: ErrorMessage
  let additionalContent: Content
  
  var body: some View {
    StateView(
      label: <#T##QuickLabel#>,
      message: <#T##String?#>,
      additionalContent: additionalContent
    )
    
  }
}

extension ErrorView {
  
}

#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  ErrorView()
  // .environment(store)
}
