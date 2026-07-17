//
//  WeightedPadding.swift
//  BaseStyles
//
//  Created by Dave Coleman on 2/3/2025.
//

import SwiftUI

public struct WeightedPaddingModifier: ViewModifier {
  @Environment(\.horizontalBias) private var horizontalBias
  @Environment(\.opticalCentreBias) private var opticalCentreBias

  let padding: CGFloat
  let horizontalBiasOverride: CGFloat?  // Increase to add width
  let opticalCentreBiasOverride: CGFloat?  // Increase to shift content upward
  let excludedEdge: Edge?

  public func body(content: Content) -> some View {
    content
      .safeAreaPadding(.top, adjustedPadding.top)
      .safeAreaPadding(.bottom, adjustedPadding.bottom)
      .safeAreaPadding(.leading, adjustedPadding.leading)
      .safeAreaPadding(.trailing, adjustedPadding.trailing)
  }
}

extension WeightedPaddingModifier {
  var adjustedPadding:
    (
      top: CGFloat?,
      bottom: CGFloat?,
      leading: CGFloat?,
      trailing: CGFloat?
    )
  {

    let biasH = 1.0 + (horizontalBiasOverride ?? horizontalBias ?? .zero)
    let biasCentre = 1.0 + (opticalCentreBiasOverride ?? opticalCentreBias ?? .zero)

    /// Calculate vertical padding with optical centre bias.
    /// Increasing opticalCentreBias increases bottom padding and decreases top padding,
    /// shifting content upward.
    let paddingTop = max(0, padding / biasCentre)
    let paddingBottom = max(0, padding * biasCentre)

    /// Calculate horizontal padding with direct bias multiplier
    let paddingH = max(0, padding * biasH)

    guard let excludedEdge else {
      /// Apply computed padding to all edges when no edge is excluded
      return (paddingTop, paddingBottom, paddingH, paddingH)
    }

    switch excludedEdge {
      case .top:
        return (nil, paddingBottom, paddingH, paddingH)

      case .bottom:
        return (paddingTop, nil, paddingH, paddingH)

      case .leading:
        return (paddingTop, paddingBottom, nil, paddingH)

      case .trailing:
        return (paddingTop, paddingBottom, paddingH, nil)
    }
  }
}

extension View {
  public func weightedPadding(
    _ padding: CGFloat,
    horizontalBias horizontalBiasOverride: CGFloat? = nil,
    opticalCentreBias opticalCentreBiasOverride: CGFloat = 0.2,
    excludedEdge: Edge? = nil,
  ) -> some View {
    self.modifier(
      WeightedPaddingModifier(
        padding: padding,
        horizontalBiasOverride: horizontalBiasOverride,
        opticalCentreBiasOverride: opticalCentreBiasOverride,
        excludedEdge: excludedEdge,
      )
    )
  }
}
