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
  @Entry public var labelTitleWeight: Font.Weight? = nil
  @Entry public var labelTitleFontStyle: Font? = nil

  // MARK: - Label Icon
  @Entry public var labelIconColour: AnyShapeStyle? = nil
  @Entry public var labelIconWeight: Font.Weight? = nil
  @Entry public var labelIconFontStyle: Font? = nil

}

// MARK: - View extensions

extension View {

  public func labelIconColour<S>(_ colour: S) -> some View where S: ShapeStyle {
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

}
