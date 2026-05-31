//
//  RGBColour+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import CoreTools
import SwiftUI

extension RGBColour: SwiftUIColourConvertible {
  public var toColour: Color {
    Color(
      colourSpace.swiftUIColourSpace,
      red: red,
      green: green,
      blue: blue,
      opacity: alpha,
    )
  }

  public init(
    fromSystem system: SystemColour,
    env: EnvironmentValues,
  ) {
    self.init(
      colour: system.toColour,
      environment: env,
      name: system.name,
    )
  }
}
