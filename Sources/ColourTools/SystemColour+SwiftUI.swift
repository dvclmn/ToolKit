//
//  SystemColour+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import AppKit
import SwiftUI
import CoreTools

extension SystemColour {

  public init?(colour: Color) {
    guard
      let match = Self.allCases.first(where: { $0.toColour == colour })
    else {
      return nil
    }
    self = match
  }

  public var toColour: Color {
    switch self {
      case .red: Color.red
      case .orange: Color.orange
      case .yellow: Color.yellow
      case .green: Color.green
      case .mint: Color.mint
      case .teal: Color.teal
      case .cyan: Color.cyan
      case .blue: Color.blue
      case .indigo: Color.indigo
      case .purple: Color.purple
      case .pink: Color.pink
      case .brown: Color.brown
      case .white: Color.white
      case .gray: Color.gray
      case .black: Color.black
      case .clear: Color.clear
      case .primary: Color.primary
      case .secondary: Color.secondary
      case .tertiary: Color(NSColor.tertiaryLabelColor)
      case .quaternary: Color(NSColor.quaternaryLabelColor)
      case .quinary: Color(NSColor.quaternaryLabelColor.opacity(0.5))
      case .accentColor: Color.accentColor
      case .link: Color(NSColor.linkColor)
    }
  }

  public func rgbColour(in env: EnvironmentValues) -> RGBColour? {
    .init(fromSystem: self, env: env)
  }
}

extension RGBColour {
  public static func system(
    _ colour: SystemColour,
    in env: EnvironmentValues
  ) -> RGBColour {
    RGBColour(fromSystem: colour, env: env)
  }
}
