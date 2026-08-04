//
//  DebugCircle.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

public struct DebugCircleModifier: ViewModifier {

  let location: CGPoint?
  let diameter: CGFloat
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        if let location {
          ZStack {
            Circle()
              .fill(.purple)
              .frame(width: diameter, height: diameter)

            Text(location.debugDescription)

              .font(.caption)
              .padding(4)
              .background(.thinMaterial)
              .clipShape(.rect(cornerRadius: 3))
              .offset(y: -diameter * 2)
          }  // END zstack
          .position(location)
        }
      }
  }
}
