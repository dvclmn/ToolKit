//
//  NamedColour.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

/// A labelled colour description for palettes, presets, and imported colour libraries.
///
/// Use `NamedColour` when a colour needs human-facing context such as a palette
/// name, source file, design token, or imported swatch label. Concrete colour
/// values such as ``RGBColour`` deliberately store only components; this wrapper
/// keeps descriptive metadata at the descriptor layer instead.
public struct NamedColour: Sendable, Codable, Hashable, Identifiable {
  public let name: String
  public let source: String
  public let colour: ColourDescriptor

  public var id: String { "\(source):\(name)" }

  public init(
    name: String,
    source: String,
    colour: ColourDescriptor,
  ) {
    self.name = name
    self.source = source
    self.colour = colour
  }
}
