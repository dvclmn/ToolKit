//
//  RGBComponent.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

//
public enum RGBComponent: String, ColourComponent {

  public typealias Model = RGBColour

  case red
  case green
  case blue
  case alpha

  public var get: (RGBColour) -> Double {
    switch self {
      case .red: { $0.red }
      case .green: { $0.green }
      case .blue: { $0.blue }
      case .alpha: { $0.alpha }
    }
  }

  public var set: (inout RGBColour, Double) -> Void {
    switch self {
      case .red: { $0.red = Double($1) }
      case .green: { $0.green = Double($1) }
      case .blue: { $0.blue = Double($1) }
      case .alpha: { $0.alpha = Double($1) }
    }
  }

  //  public var keyPath: WritableKeyPath<Model, UnitInterval> {
  //  public var keyPath: WritableKeyPath<Model, Double> {
  //    switch self {
  //      case .red: \.red
  //      case .green: \.green
  //      case .blue: \.blue
  //      case .alpha: \.alpha
  //    }
  //  }

  public var nameInitial: Character {
    switch self {
      case .red: "R"
      case .green: "G"
      case .blue: "B"
      case .alpha: "A"
    }
  }

}
