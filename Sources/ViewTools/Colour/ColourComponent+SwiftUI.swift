//
//  ColourComponent+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

public protocol SwiftUIColourComponent: ColourComponent {
  func sliderTrackGradient(colour: Model) -> LinearGradient
}

extension RGBComponent: SwiftUIColourComponent {
  public func sliderTrackGradient(colour: RGBColour) -> LinearGradient {
    func makeColour(
      r: Double,
      g: Double,
      b: Double,
      opacity: Double = 1.0
    ) -> Color {
      Color(red: r, green: g, blue: b).opacity(opacity)
    }

    let (start, end): (Color, Color)

    switch self {
      case .red:
        start = makeColour(r: 0.0, g: colour.green, b: colour.blue)
        end = makeColour(r: 1.0, g: colour.green, b: colour.blue)

      case .green:
        start = makeColour(r: colour.red, g: 0.0, b: colour.blue)
        end = makeColour(r: colour.red, g: 1.0, b: colour.blue)

      case .blue:
        start = makeColour(r: colour.red, g: colour.green, b: 0.0)
        end = makeColour(r: colour.red, g: colour.green, b: 1.0)

      case .alpha:
        let base = makeColour(r: colour.red, g: colour.green, b: colour.blue)
        start = base.opacity(0.0)
        end = base.opacity(1.0)
    }

    return LinearGradient(
      colors: [start, end],
      startPoint: .leading,
      endPoint: .trailing
    )
  }
}

extension HSVComponent: SwiftUIColourComponent {
  public func gradientColours(_ colour: Model) -> [Color] {
    switch self {
      case .hue: Array<Color>.rainbow
      case .saturation:
        [.gray, colour.toColour]
      case .brightness:
        [.black, .white]
      case .alpha:
        [.clear, colour.toColour]
    }
  }

  public func sliderTrackGradient(colour: HSVColour) -> LinearGradient {
    LinearGradient(
      colors: gradientColours(colour),
      startPoint: .leading,
      endPoint: .trailing
    )
  }
}

extension LinearGradient {
  public static func rainbow(
    start: UnitPoint = .leading,
    end: UnitPoint = .trailing,
  ) -> LinearGradient {
    LinearGradient(
      colors: .rainbow,
      startPoint: start,
      endPoint: end,
    )
  }
}

extension Array where Element == Color {
  public static let rainbow: [Color] = [
    .red, .orange, .yellow, .green, .blue, .indigo, .purple, .pink, .red,
  ]
}
