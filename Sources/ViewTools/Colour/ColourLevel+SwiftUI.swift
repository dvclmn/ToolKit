//
//  ColourLevel+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension Binding where Value == RGBColour {

  public static func dualColourBinding(
    _ primary: Binding<RGBColour>,
    _ secondary: Binding<RGBColour?>,
    level: ColourLevel,
  ) -> Binding<RGBColour> {
    Binding<RGBColour> {

      if level.isForeground {
        return primary.wrappedValue
      }

      guard let secondary = secondary.wrappedValue else {
        return primary.wrappedValue
      }

      return secondary

    } set: {
      if level.isForeground {
        primary.wrappedValue = $0
      } else {
        secondary.wrappedValue = $0
      }
    }
  }
}
