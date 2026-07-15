//
//  ColourStylable.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

public protocol ColourStylable {
  var colourStyle: ColourStyle { get set }
  
//  init (style: ColourStyle)
}

extension ColourStylable {
  public var baseColour: RGBColour? {
    switch colourStyle {
      case .solid(let colour): colour.rgbColour
      case .gradient(let colours): colours.first?.rgbColour
      case .mix(let start, _, _): start.rgbColour
    }
  }

//  public init(_ rgbColour: RGBColour) {
//    self.init(style: .solid(.init(rgbColour)))
////    self = .solid(.rgb(rgbColour))
//  }

}
