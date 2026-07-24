//
//  ColourStyle.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

import SwiftUI

// TODO: Can this produce a SwiftUI ShapeStyle?
public enum ColourStyle: Sendable, Hashable, Codable {

  case solid(ColourDescriptor)

  // TODO: Just linear for now, maybe support more later
  case gradient([ColourDescriptor])

  /// A solid colour produced by perceptually interpolating from `from` to `to`.
  /// A strength of `0` returns `from`; a strength of `1` returns `to`.
  case mix(
    from: ColourDescriptor,
    to: ColourDescriptor,
    amount: Double,
  )
}

extension ColourStyle {
  //  public var colours: [Color] {
  //    resolvedColours(fallback: .clear)
  //  }

  public func resolvedColours(fallback: Color? = nil) -> [Color] {
    let colours: [Color]

    switch self {
      case .solid(let colour):
        colours = [colour.swiftUIColor].compactMap(\.self)

      case .gradient(let colourStops):
        colours = colourStops.compactMap(\.swiftUIColor)

      case .mix(let from, let to, let amount):
        let fromColour = from.swiftUIColor
        let toColour = to.swiftUIColor
        if let fromColour, let toColour {
          colours = [
            fromColour.mixCompatible(
              with: toColour,
              by: amount,
              in: .perceptual,
            )
          ]
        } else {
          colours = [fromColour ?? toColour].compactMap(\.self)
        }
    }

    guard colours.isEmpty, let fallback else {
      return colours
    }
    return [fallback]

  }
}
