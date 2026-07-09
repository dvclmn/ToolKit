//
//  QuickBackgroundSurface.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import CoreTools
import SwiftUI

struct QuickBackgroundSurface<S: Shape>: View {
  @Environment(\.backgroundMaterial) private var backgroundMaterial
  @Environment(\.colourOverride) private var colourOverride
  @Environment(\.strokeColour) private var strokeColour
  @Environment(\.strokeWeight) private var strokeWeight
  @Environment(\.colourIntensity) private var colourIntensity

  let isEnabled: Bool
  let shape: S
  let glass: GlassTypeCompatible?
  let tint: Color?

  var body: some View {
    if glass == nil {
      shape
        .fill(backgroundColour.opacity(colourIntensity ?? 0.3))
        .fill(material)
        .stroke(
          LinearGradient.lightFalloff(
            .white.opacity(0.08),
            direction: .topLeading,
            falloffAmount: 0.9,
          ),
          lineWidth: strokeWeight ?? 1,
        )
        .stroke(
          strokeColour ?? AnyShapeStyle(Color.gray.opacity(0.08)),
          lineWidth: strokeWeight ?? 1,
        )
    }
  }
}

extension QuickBackgroundSurface {
  private var backgroundColour: Color {
    colourOverride ?? tint ?? .clear
  }

  private var material: AnyShapeStyle {
    guard isEnabled else { return .clear }
    return AnyShapeStyle(backgroundMaterial ?? .regularMaterial)
  }
}
