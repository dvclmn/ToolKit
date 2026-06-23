//
//  ColourMixing+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension Color {
  public func mixCompatible(
    with rhs: Self,
    by fraction: Double,
    in colorSpace: Gradient.ColorSpace = .perceptual,
  ) -> Self {
    guard #available(macOS 15, iOS 18, *) else {
      return self
    }
    return self.mix(
      with: rhs,
      by: fraction,
      in: colorSpace,
    )
  }
}

extension Array where Element == Color {
  /// Mix an array of colours into a single colour by repeatedly blending.
  public func mixMultiple(
    by fraction: Double = 0.5,
    fallback: Color = .clear,
  ) -> Color {
    guard let first = self.first else { return fallback }
    return self.dropFirst().reduce(first) { accumulated, next in
      accumulated.mixCompatible(with: next, by: fraction)
    }
  }
}

extension SystemColour {
  public func withMix(_ colour: Self, _ amount: Double) -> Color {
    self.toColour.mixCompatible(
      with: colour.toColour,
      by: amount,
      in: .perceptual,
    )
  }
}
