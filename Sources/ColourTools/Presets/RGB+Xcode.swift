//
//  RGB+Presets.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

extension RGBColour {
  public enum Xcode {
    // MARK: - Main Editor Colors
    public static let background: RGBColour = .init(
      r: 0.098455, g: 0.102102, b: 0.116688)
    public static let backgroundHighlight: RGBColour = .init(
      r: 0.138526, g: 0.146864, b: 0.169283)
    public static let selection: RGBColour = .init(
      r: 0.317647, g: 0.356862, b: 0.439215)
    public static let insertionPoint: RGBColour = .init(
      r: 0.040815, g: 0.374814, b: 0.998368)
    public static let invisibles: RGBColour = .init(
      r: 0.457816, g: 0.532248, b: 0.629581)

    // MARK: - Syntax Highlighting Colors
    public static let comment: RGBColour = .init(r: 0.423529, g: 0.47451, b: 0.52549)
    public static let documentationComment: RGBColour = .init(
      r: 0.517677, g: 0.579556, b: 0.641301)
    public static let keyword: RGBColour = .init(r: 0.988394, g: 0.37355, b: 0.638329)
    public static let string: RGBColour = .init(r: 0.988235, g: 0.415686, b: 0.364706)
    public static let number: RGBColour = .init(r: 0.814983, g: 0.749393, b: 0.412334)
    public static let function: RGBColour = .init(
      r: 0.403922, g: 0.717647, b: 0.643137)
    public static let systemFunction: RGBColour = .init(
      r: 0.631373, g: 0.403922, b: 0.901961)
    public static let type: RGBColour = .init(r: 0.621449, g: 0.943864, b: 0.868194)
    public static let systemType: RGBColour = .init(
      r: 0.816806, g: 0.656917, b: 0.999271)
    public static let macro: RGBColour = .init(r: 0.991311, g: 0.560764, b: 0.246107)
    public static let attribute: RGBColour = .init(
      r: 0.74902, g: 0.521569, b: 0.333333)
    public static let url: RGBColour = .init(r: 0.330191, g: 0.511266, b: 0.998589)
    public static let plainText: RGBColour = .init(r: 1.0, g: 1.0, b: 1.0)

    // MARK: - Markup Colors (Documentation)
    public static let markupBackground: RGBColour = .init(
      r: 0.18856, g: 0.195, b: 0.22444)
    public static let markupBorder: RGBColour = .init(
      r: 0.253475, g: 0.2594, b: 0.286485)
    public static let markupText: RGBColour = .init(r: 1.0, g: 1.0, b: 1.0)
    public static let markupLink: RGBColour = .init(
      r: 0.33, g: 0.247124, b: 0.894195)
    public static let markupInlineCode: RGBColour = .init(
      r: 1.0, g: 1.0, b: 1.0)

    // MARK: - Scrollbar Markers (Gutter Indicators)
    public static let errorMarker: RGBColour = .init(
      r: 0.968627, g: 0.290196, b: 0.290196)
    public static let warningMarker: RGBColour = .init(
      r: 0.937255, g: 0.717647, b: 0.34902)
    public static let breakpointMarker: RGBColour = .init(
      r: 0.290196, g: 0.290196, b: 0.968627)
    public static let analyzerMarker: RGBColour = .init(
      r: 0.403922, g: 0.372549, b: 1.0)
    public static let runtimeIssueMarker: RGBColour = .init(
      r: 0.643137, g: 0.509804, b: 1.0)

    // MARK: - Console Colors
    public static let consoleBackground: RGBColour = .init(
      r: 0.120543, g: 0.122844, b: 0.141312)
    public static let consoleInput: RGBColour = .init(
      r: 0.771962, g: 1.0, b: 0.745793)
    public static let consoleOutput: RGBColour = .init(
      r: 1.0, g: 0.539144, b: 0.409662)
    public static let consolePrompt: RGBColour = .init(
      r: 0.309804, g: 0.788235, b: 0.254902)
    public static let consoleExecutableInput: RGBColour = .init(
      r: 0.762626, g: 1.0, b: 0.3909)
    public static let consoleExecutableOutput: RGBColour = .init(
      r: 1.0, g: 1.0, b: 1.0)

  }
}
