//
//  ColourStylable.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

public protocol ColourStylable {
  var style: ColourStyle { get set }
}

extension ColourStylable {
  public var baseColour: ColourDescriptor? {
//  public var baseColour: RGBColour? {
    switch style {
      case .solid(let colour): colour
      case .gradient(let colours): colours.first
      case .mix(let start, let end, let amount):
        
    }
  }
}
