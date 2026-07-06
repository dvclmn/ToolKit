//
//  ColourPreset.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public struct ColourMix: Sendable, Codable, Equatable, Hashable {

  //  public let base: SystemColour
  //  public let mix: SystemColour?
  //  public let mixAmount: Double

  public var primary: RGBColour
  public var secondary: RGBColour?
  public var strength: Double

  public init(
    primary: RGBColour,
    secondary: RGBColour?,
    strength: Double = 1.0,
  ) {
    self.primary = primary
    self.secondary = secondary
    self.strength = strength
  }
}
extension ColourMix {

  public var colour: Color {
    guard let secondary else { return primary.toColour }
    return primary.withMix(secondary, strength)
  }

  public static func solid(colour: RGBColour) -> Self {
    .init(primary: colour, secondary: nil)
  }
  
  public var isSolidColour: Bool { secondary == nil }
}

extension RGBColour {
  public func withMix(_ other: Self, _ amount: Double) -> Color {
    self.toColour.mixCompatible(
      with: other.toColour,
      by: amount,
      in: .perceptual,
    )
  }
}

// MARK: - Examples
extension ColourMix {

  public static let greenNeon: Self = .init(
    primary: .green,
    secondary: .yellow,
    strength: 0.36,
  )

  public static let pinkNeon: Self = .init(
    primary: .pink,
    secondary: .blue,
    strength: 0.46,
  )
}
