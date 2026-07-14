//
//  Env+Helpers.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI

extension View {

  public func isDebugMode(_ mode: Bool) -> some View {
    self.environment(\.isDebugMode, mode)
  }

  /// Adds a String value to Environment Key `helpText`, and sets
  /// value for SwiftUI `help(:)`
  public func helpText(_ text: String) -> some View {
    self
      .environment(\.helpText, text)
      .help(text)
  }
}
