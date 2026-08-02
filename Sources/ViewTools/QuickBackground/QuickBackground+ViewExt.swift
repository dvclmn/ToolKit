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
    glass: GlassTypeCompatible? = nil,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickRoundedRectangularBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        glass: glass,
        tint: tint,
      )
    )
  }
  
  /// This overload preserves rounded-rectangular container metadata for
  /// `ContainerRelativeShape` and, on macOS 26+, `ConcentricRectangle`.
  @available(*, deprecated, renamed: "quickBackground(shape:glass:tint:isEnabled:)", message: "Padding is no longer handled inside QuickBackground.")
  public func quickBackground<S: RoundedRectangularShapeCompatible>(
    shape: S = .rect(cornerRadius: Styles.sizeSmall),
    glass: GlassTypeCompatible? = nil,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    quickBackground(shape: shape, glass: glass, tint: tint, isEnabled: isEnabled)
  }

  /// Applies the QuickBackground treatment to any SwiftUI `Shape`.
  ///
  /// This route intentionally skips rounded-rectangular container metadata,
  /// because arbitrary shapes cannot always describe truthful corner geometry.
  public func quickBackground<S: Shape>(
    customShape shape: S,
    glass: GlassTypeCompatible? = nil,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        glass: glass,
        tint: tint,
      )
    )
  }
  
  /// Applies the QuickBackground treatment to any SwiftUI `Shape`.
  ///
  /// This route intentionally skips rounded-rectangular container metadata,
  /// because arbitrary shapes cannot always describe truthful corner geometry.
  @available(*, deprecated, renamed: "quickBackground(customShape:glass:tint:isEnabled:)", message: "Padding is no longer handled inside QuickBackground.")
  public func quickBackground<S: Shape>(
    customShape shape: S,
    glass: GlassTypeCompatible? = nil,
    padding: CGFloat = Styles.sizeTiny,
    tint: Color? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    quickBackground(customShape: shape, glass: glass, tint: tint, isEnabled: isEnabled)
  }

//  public func quickRoundedBackground(
//    rounding: Double = Styles.sizeSmall,
//    glass: GlassTypeCompatible? = nil,
//    padding: CGFloat = Styles.sizeTiny,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      QuickRoundedRectangularBackgroundModifier(
//        isEnabled: isEnabled,
//        shape: .rect(cornerRadius: rounding),
//        glass: glass,
//        padding: padding,
//        tint: tint,
//      )
//    )
//  }
}
