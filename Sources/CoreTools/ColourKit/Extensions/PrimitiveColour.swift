//
//  PrimitiveColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/8/2025.
//

/// This is referring to basic colours like "red" and "green",
/// as opposed to fancy shades like "peach" or "teal"
public enum PrimitiveColour: String, Identifiable, CaseIterable, Sendable {
  case red
  case orange
  case yellow
  case green
  case blue
  case purple
  case pink
  case brown
  case grey
  case black
  case white
  case none

//  #warning("Turn back on if Swatch survives")
  //  public init?(fromSwatch swatch: Swatch) {
  //    let lower = swatch.rawValue.lowercased()
  //
  //    guard let match = PrimitiveColour.allCases.first(where: { lower.contains($0.rawValue) }) else {
  //      return nil
  //    }
  //    self = match
  //  }
  public var name: String { rawValue.capitalized }

  public var id: String { rawValue }

  public var toSystemColour: SystemColour? {
    SystemColour(rawValue: self.rawValue)
  }
}

/// This drives table sorting in UI layers.
extension PrimitiveColour: Comparable {

  public var sortIndex: Int {
    PrimitiveColour.allCases.firstIndex(of: self) ?? 0
  }

  public static func < (lhs: PrimitiveColour, rhs: PrimitiveColour) -> Bool {
    lhs.sortIndex < rhs.sortIndex
  }

}
