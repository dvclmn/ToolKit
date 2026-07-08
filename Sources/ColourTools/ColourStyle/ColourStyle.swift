//
//  ColourStyle.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

// TODO: Can this produce a SwiftUI ShapeStyle?
public enum ColourStyle {

  case solid(RGBColour)

  // TODO: Just linear for now, maybe support more later
  case gradient([RGBColour])

  /// Returns a solid colour from a blend of two other colours
  case blend(from: RGBColour, to: RGBColour, strength: Double)
}
