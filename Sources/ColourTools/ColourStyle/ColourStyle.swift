//
//  ColourStyle.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

public enum ColourStyle {
  case solid(RGBColour)
  case gradient([RGBColour])
  case blend(from colour: RGBColour, to: RGBColour, strength: Double)
}
