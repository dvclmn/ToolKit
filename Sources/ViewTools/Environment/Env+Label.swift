//
//  Env+Label.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI

extension EnvironmentValues {

  // MARK: - Label (general)

  @Entry public var labelTextCase: Text.Case? = nil

  // Useful when awareness of this layout information is... useful
  /// True when label is displayed in a vertical stack, usually with a larger icon size.
  /// For instance in ErrorView, which is based on ContentUnavailableView.
//  @Entry public var isLabelStacked: Bool = false

  /// This is useful because SwiftUI exposes control over display of
  /// icon and label elements in the form of the `LabelStyle` protocol.
  /// So when using custom label styles, setting e.g. `labelStyle(.iconOnly)`
  /// will override the custom style. This works around that.
  @Entry public var labelDisplay: LabelDisplay? = nil

  // MARK: - Label Title
//  @Entry public var labelTitleColour: AnyShapeStyle? = nil
  @Entry public var labelTitleWeight: Font.Weight? = nil
  @Entry public var labelTitleFontStyle: Font? = nil
//  @Entry public var labelTitleFontStyle: Font.TextStyle? = nil

  // Turning this off, will try deferring to font style instead
  //  @Entry public var labelFontSize: CGFloat? = nil

  // MARK: - Label Icon
  @Entry public var labelIconColour: AnyShapeStyle? = nil
  //  @Entry public var iconColour: AnyShapeStyle? = nil
  @Entry public var labelIconWeight: Font.Weight? = nil
  //  @Entry public var iconWeight: Font.Weight? = nil

  // Also retired for now, along with label title equivalent
  //  @Entry public var iconFontSize: CGFloat? = nil
  @Entry public var labelIconFontStyle: Font? = nil
//  @Entry public var labelIconFontStyle: Font.TextStyle? = nil

  /// Already a native value for this: `labelIconToTitleSpacing`
  //  @Entry public var labelIconSpacing: CGFloat? = nil

}

// MARK: - View extensions

extension View {

  // If setting colour for *both*, then standard `foregroundStyle()`
  // modifier should work, no need for multiple calls of this
//  public func labelColour<S>(
//    for part: LabelPart = .title,
//    _ colour: S,
//  ) -> some View where S: ShapeStyle {
//    self.environment(part.isTitle ? \.labelTitleColour : \.labelIconColour, AnyShapeStyle(colour))
//  }
  
  public func labelIconColour<S>(
//    for part: LabelPart = .title,
    _ colour: S,
  ) -> some View where S: ShapeStyle {
    self.environment(\.labelIconColour, AnyShapeStyle(colour))
  }

  public func labelFontWeight(
    for part: LabelPart = .title,
    _ weight: Font.Weight,
  ) -> some View {
    self.environment(part.isTitle ? \.labelTitleWeight : \.labelIconWeight, weight)
  }

  public func labelFontStyle(
    for part: LabelPart = .title,
    _ style: Font,
  ) -> some View {
    self.environment(part.isTitle ? \.labelTitleFontStyle : \.labelIconFontStyle, style)
  }

  public func labelTextCase(_ textCase: Text.Case) -> some View {
    self.environment(\.labelTextCase, textCase)
  }

  //  public func labelFontStyle(_ style: Font.TextStyle) -> some View {
  //    self.environment(\.labelFontStyle, style)
  //  }

  /// Font weight
  /// Symbol rendering mode (e.g. hierarchy) / variant (e.g. fill)
  /// Foreground style
  //  public func iconWeight(_ weight: Font.Weight) -> some View {
  //    self.environment(\.iconWeight, weight)
  //  }

  //  public func iconColour<S>(_ colour: S) -> some View where S: ShapeStyle {
  //    self.environment(\.iconColour, AnyShapeStyle(colour))
  //  }

  //  public func labelWeight(_ weight: Font.Weight) -> some View {
  //    self.environment(\.labelWeight, weight)
  //  }

  //  public func labelTitleColour<S>(_ colour: S) -> some View where S: ShapeStyle {
  //    self.environment(\.labelTitleColour, AnyShapeStyle(colour))
  //  }

//  public func labelFontSize(_ size: CGFloat) -> some View {
//    self.environment(\.labelFontSize, size)
//  }

}
