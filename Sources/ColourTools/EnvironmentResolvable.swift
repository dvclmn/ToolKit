//
//  EnvironmentResolvable.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI
import CoreTools

public protocol EnvironmentResolvableColour {

  /// Creates a concrete model colour by resolving a SwiftUI colour in an environment.
  init(
    colour: Color,
    environment: EnvironmentValues
  )

  /// Creates a concrete model colour from SwiftUI's resolved component values.
  init(resolved: Color.Resolved)
}

extension RGBColour: EnvironmentResolvableColour {

  public func toCGColour(in env: EnvironmentValues) -> CGColor? {
    toColour.resolve(in: env).cgColor
  }
}

extension RGBColour {
  public init(
    colour: Color,
    environment: EnvironmentValues
  ) {
    let resolved = colour.resolve(in: environment)
    self.init(resolved: resolved)
  }

  public init(resolved: Color.Resolved) {
    self.init(
      red: resolved.red.toDouble,
      green: resolved.green.toDouble,
      blue: resolved.blue.toDouble,
      alpha: resolved.opacity.toDouble
    )
  }
}

extension HSVColour: EnvironmentResolvableColour {

}

extension HSVColour {

  public init(
    colour: Color,
    environment: EnvironmentValues
  ) {
    let resolved = colour.resolve(in: environment)
    self.init(resolved: resolved)
  }

  public init(resolved: Color.Resolved) {
    self.init(fromRGB: RGBColour(resolved: resolved))
  }
}
