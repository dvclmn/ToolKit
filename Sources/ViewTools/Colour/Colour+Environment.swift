//
//  Colour+Environment.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension EnvironmentValues {
  @Entry public var rgbComponent: RGBComponent?
  @Entry public var hsvComponent: HSVComponent?

  /// Colour adjustments, see ``ColourModification``
  @Entry public var colourModification: ColourModification?
  @Entry public var colourModificationStrength: ModificationStrengthPreset?
  @Entry public var colourPurpose: ColourPurpose?
  @Entry public var colourChroma: ColourChroma?

  @Entry public var activeColourHierarchy: Binding<HierarchicalColour> = .constant(.primary)
  @Entry public var activeColourModel: Binding<ColourModelKind> = .constant(.rgb)
  @Entry public var hsvPrimaryRepresentation: Binding<HSVColour>? = nil
}
