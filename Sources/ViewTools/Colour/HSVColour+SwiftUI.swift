//
//  HSVColour+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension HSVColour: SwiftUIColourConvertible {

  public var toColour: Color {
    Color(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      opacity: alpha
    )
  }
}
