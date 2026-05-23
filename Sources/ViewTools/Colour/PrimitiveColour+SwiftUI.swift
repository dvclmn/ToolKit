//
//  PrimitiveColour+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension PrimitiveColour {
  public var toColour: Color {
    switch self {
      case .red: Color.red
      case .orange: Color.orange
      case .yellow: Color.yellow
      case .green: Color.green
      case .blue: Color.blue
      case .purple: Color.purple
      case .pink: Color.pink
      case .brown: Color.brown
      case .grey: Color.gray
      case .black: Color.black
      case .white: Color.white
      case .none: Color.clear
    }
  }
}
