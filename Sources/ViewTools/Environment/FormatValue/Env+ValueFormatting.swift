//
//  Env+ValueFormatting.swift
//  ToolKit
//
//  Created by Dave Coleman on 22/3/2026.
//

import CoreTools
import StringTools
import SwiftUI

// MARK: - Environment values
extension EnvironmentValues {

  @Entry public var formatValue: ValueFormatter = .default

  /// E.g. 3 places: `10.056` or one place: `10.1`
  /// See `Foundation/NumberFormatStyleConfiguration/Precision`
  /// This imposes a fixed number (no min or max) of places.
  @Entry public var fractionLength: Int?

  /// E.g. 3 places: `023.6` or two places: `23.6`
  /// As implied in the name, this won't impose an upper limit,
  /// only ensure there are at least 'x' integers
  @Entry public var minIntegerLength: Int?
}

public protocol ValueFormattable {}

extension View {
  public func formatValue(_ format: @escaping @Sendable (Double) -> String) -> some View {
    self.environment(\.formatValue, ValueFormatter(format))
  }

  public func formatValue(_ preset: FloatDisplayPreset) -> some View {
    self.environment(\.formatValue, ValueFormatter { $0.displayString(preset) })
  }

  public func formatValue(_ formatter: ValueFormatter) -> some View {
    self.environment(\.formatValue, formatter)
  }
}
