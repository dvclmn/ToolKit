//
//  QuickBackground+ViewExt.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

extension View {

//  public func quickBackground(
//    rounding: CGFloat = Styles.sizeSmall,
//    style: QuickBackgroundStyle = .glass(.regular),
////    glass: GlassTypeCompatible? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      QuickRoundedRectangularBackgroundModifier(
//        isEnabled: isEnabled,
//        shape: .rect(cornerRadius: rounding),
//        style: style,
////        style: .glass(glass),
//        //        glass: glass,
//        //        tint: tint,
//      )
//    )
//  }

//  public func quickBackground(
//    rounding: CGFloat = Styles.sizeSmall,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      QuickRoundedRectangularBackgroundModifier(
//        isEnabled: isEnabled,
//        shape: .rect(cornerRadius: rounding),
//        style: .standard(tint: tint),
//      )
//    )
//  }

  /// This overload preserves rounded-rectangular container metadata for
  /// `ContainerRelativeShape` and, on macOS 26+, `ConcentricRectangle`.
  public func quickBackground<S: RoundedRectangularShapeCompatible>(
    shape: S,
    style: QuickBackgroundStyle = .glass(.regular),
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickRoundedRectangularBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        style: style
      )
    )
  }
//  @available(
//    *, deprecated, renamed: "quickBackground(shape:glass:tint:isEnabled:)",
//    message: "Padding is no longer handled inside QuickBackground."
//  )
//  public func quickBackground<S: RoundedRectangularShapeCompatible>(
//    shape: S = .rect(cornerRadius: Styles.sizeSmall),
//    glass: GlassTypeCompatible? = nil,
//    padding: CGFloat = Styles.sizeTiny,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    return quickBackground(
//      shape: shape,
//      glass: glass,
//      tint: tint,
//      isEnabled: isEnabled
//    )
//  }

  /// Applies the QuickBackground treatment to any SwiftUI `Shape`.
  ///
  /// This route intentionally skips rounded-rectangular container metadata,
  /// because arbitrary shapes cannot always describe truthful corner geometry.
  public func quickBackground<S: Shape>(
    shape: S,
    style: QuickBackgroundStyle = .glass(.regular),
//    glass: GlassTypeCompatible? = nil,
    isEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      QuickShapeBackgroundModifier(
        isEnabled: isEnabled,
        shape: shape,
        style: style
//        style: .glass(glass),
      )
    )
  }

  /// Applies the QuickBackground treatment to any SwiftUI `Shape`.
  ///
  /// This route intentionally skips rounded-rectangular container metadata,
  /// because arbitrary shapes cannot always describe truthful corner geometry.
//  public func quickBackground<S: Shape>(
//    shape: S,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      QuickShapeBackgroundModifier(
//        isEnabled: isEnabled,
//        shape: shape,
//        style: .standard(tint: tint),
//      )
//    )
//  }

  /// Applies the QuickBackground treatment to any SwiftUI `Shape`.
  ///
  /// This route intentionally skips rounded-rectangular container metadata,
  /// because arbitrary shapes cannot always describe truthful corner geometry.
//  @available(
//    *, deprecated, renamed: "quickBackground(shape:glass:tint:isEnabled:)",
//    message: "Padding is no longer handled inside QuickBackground."
//  )
//  public func quickBackground<S: Shape>(
//    customShape shape: S,
//    glass: GlassTypeCompatible? = nil,
//    padding: CGFloat = Styles.sizeTiny,
//    tint: Color? = nil,
//    isEnabled: Bool = true,
//  ) -> some View {
//    return quickBackground(customShape: shape, glass: glass, tint: tint, isEnabled: isEnabled)
//  }
}
