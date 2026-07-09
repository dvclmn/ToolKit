//
//  QuickBackground+ViewExt.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

extension View {
  /// This overload preserves rounded-rectangular container metadata for
  /// `ContainerRelativeShape` and, on macOS 26+, `ConcentricRectangle`.
  public func quickBackground<S: RoundedRectangularShapeCompatible>(
    shape: S = .rect(cornerRadius: Styles.sizeSmall),
    padding: CGFloat = Styles.sizeTiny,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickRoundedRectangularBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        glass: nil,
        padding: padding,
        tint: tint,
      )
    )
  }

//  /// This overload doesn't need an explicit `rounding`
//  /// argument, as it's handled through `shape`
//  public func quickBackground<S: Shape>(
//    shape: S = .rect(cornerRadius: Styles.sizeSmall),
//    padding: CGFloat = Styles.sizeTiny,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      QuickBackgroundModifier(
//        isEnabled: isEnabled,
//        shape: shape,
//        glass: nil,
//        padding: padding,
//        tint: tint,
//      )
//    )
//  }

  public func quickRoundedBackground(
    glass: GlassTypeCompatible? = nil,
    rounding: Double = Styles.sizeSmall,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickRoundedRectangularBackgroundModifier(
        isEnabled: isEnabled,
        shape: .rect(cornerRadius: rounding),
        glass: glass,
        padding: padding,
        tint: tint,
      )
    )
  }
}
