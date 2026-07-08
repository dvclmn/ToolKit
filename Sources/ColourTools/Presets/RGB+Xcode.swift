//
//  RGB+Presets.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/10/2025.
//

// swift-format-ignore-file

import Foundation

extension RGBColour {
  public enum Xcode {
    // MARK: - Main Editor Colors
    public static let background: RGBColour =                  #colorLiteral(      red: 0.098455, green: 0.102102, blue: 0.116688, alpha: 1.0)
    public static let backgroundHighlight: RGBColour =         #colorLiteral(red: 0.138526, green: 0.146864, blue: 0.169283, alpha: 1.0)
    public static let selection: RGBColour =                   #colorLiteral(red: 0.317647, green: 0.356862, blue: 0.439215, alpha: 1.0)
    public static let insertionPoint: RGBColour =              #colorLiteral(red: 0.040815, green: 0.374814, blue: 0.998368, alpha: 1.0)
    public static let invisibles: RGBColour =                  #colorLiteral(red: 0.457816, green: 0.532248, blue: 0.629581, alpha: 1.0)

    // MARK: - Syntax Highlighting Colors
    public static let comment: RGBColour =                     #colorLiteral(red: 0.423529, green: 0.47451, blue: 0.52549, alpha: 1.0)
    public static let documentationComment: RGBColour =        #colorLiteral(red: 0.517677, green: 0.579556, blue: 0.641301, alpha: 1.0)
    public static let keyword: RGBColour =                     #colorLiteral(red: 0.988394, green: 0.37355, blue: 0.638329, alpha: 1.0)
    public static let string: RGBColour =                      #colorLiteral(red: 0.988235, green: 0.415686, blue: 0.364706, alpha: 1.0)
    public static let number: RGBColour =                      #colorLiteral(red: 0.814983, green: 0.749393, blue: 0.412334, alpha: 1.0)
    public static let function: RGBColour =                    #colorLiteral(red: 0.403922, green: 0.717647, blue: 0.643137, alpha: 1.0)
    public static let systemFunction: RGBColour =              #colorLiteral(red: 0.631373, green: 0.403922, blue: 0.901961, alpha: 1.0)
    public static let type: RGBColour =                        #colorLiteral(red: 0.621449, green: 0.943864, blue: 0.868194, alpha: 1.0)
    public static let systemType: RGBColour =                  #colorLiteral(red: 0.816806, green: 0.656917, blue: 0.999271, alpha: 1.0)
    public static let macro: RGBColour =                       #colorLiteral(red: 0.991311, green: 0.560764, blue: 0.246107, alpha: 1.0)
    public static let attribute: RGBColour =                   #colorLiteral(red: 0.74902, green: 0.521569, blue: 0.333333, alpha: 1.0)
    public static let url: RGBColour =                         #colorLiteral(red: 0.330191, green: 0.511266, blue: 0.998589, alpha: 1.0)
    public static let plainText: RGBColour =                   #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    // MARK: - Markup Colors (Documentation)
    public static let markupBackground: RGBColour =            #colorLiteral(red: 0.18856, green: 0.195, blue: 0.22444, alpha: 1.0)
    public static let markupBorder: RGBColour =                #colorLiteral(red: 0.253475, green: 0.2594, blue: 0.286485, alpha: 1.0)
    public static let markupText: RGBColour =                  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public static let markupLink: RGBColour =                  #colorLiteral(red: 0.33, green: 0.247124, blue: 0.894195, alpha: 1.0)
    public static let markupInlineCode: RGBColour =            #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    // MARK: - Scrollbar Markers (Gutter Indicators)
    public static let errorMarker: RGBColour =                 #colorLiteral(red: 0.968627, green: 0.290196, blue: 0.290196, alpha: 1.0)
    public static let warningMarker: RGBColour =               #colorLiteral(red: 0.937255, green: 0.717647, blue: 0.34902, alpha: 1.0)
    public static let breakpointMarker: RGBColour =            #colorLiteral(red: 0.290196, green: 0.290196, blue: 0.968627, alpha: 1.0)
    public static let analyzerMarker: RGBColour =              #colorLiteral(red: 0.403922, green: 0.372549, blue: 1.0, alpha: 1.0)
    public static let runtimeIssueMarker: RGBColour =          #colorLiteral(red: 0.643137, green: 0.509804, blue: 1.0, alpha: 1.0)

    // MARK: - Console Colors
    public static let consoleBackground: RGBColour =           #colorLiteral(red: 0.120543, green: 0.122844, blue: 0.141312, alpha: 1.0)
    public static let consoleInput: RGBColour =                #colorLiteral(red: 0.771962, green: 1.0, blue: 0.745793, alpha: 1.0)
    public static let consoleOutput: RGBColour =               #colorLiteral(red: 1.0, green: 0.539144, blue: 0.409662, alpha: 1.0)
    public static let consolePrompt: RGBColour =               #colorLiteral(red: 0.309804, green: 0.788235, blue: 0.254902, alpha: 1.0)
    public static let consoleExecutableInput: RGBColour =      #colorLiteral(red: 0.762626, green: 1.0, blue: 0.3909, alpha: 1.0)
    public static let consoleExecutableOutput: RGBColour =     #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

  }
}
