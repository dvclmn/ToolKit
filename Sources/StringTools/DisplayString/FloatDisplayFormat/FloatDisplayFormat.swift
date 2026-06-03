//
//  FloatDisplayFormat.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation
import CoreTools

/// Describes how a single floating-point value is formatted.
/// Deliberately limited to numeric concerns only — no separator,
/// label, or grouping/joining logic lives here.
public struct FloatDisplayFormat: Equatable, Sendable {
  /// Number of fractional decimal places to render.
  public var decimalPlaces: Int
  
  /// Optional minimum number of integer digits to render.
  public var integerLength: Int?
  
  /// Grouping strategy for the integer part.
  public var grouping: NumberGrouping
  
  /// Sign rendering strategy.
  public var sign: SignDisplay

  public init(
    decimalPlaces: Int = 2,
    integerLength: Int? = nil,
    grouping: NumberGrouping = .automatic,
    sign: SignDisplay = .standard
  ) {
    self.decimalPlaces = decimalPlaces
    self.integerLength = integerLength
    self.grouping = grouping
    self.sign = sign
  }
}

extension FloatDisplayFormat {
  /// Returns the format associated with a preset.
  public static func fromPreset(_ preset: FloatDisplayPreset) -> Self {
    preset.format
  }

  /// Returns a copy with an integer-length requirement.
  public func with(integerLength: Int) -> Self {
    var copy = self
    copy.integerLength = integerLength
    return copy
  }

  public static var `default`: Self { .init() }
}

extension BinaryFloatingPoint {
  /// Converts the value to a percentage string within a range.
  public func toPercentString(
    within range: ClosedRange<Self>,
    decimalPlaces: Int = 0
  ) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.render(using: .init(decimalPlaces: decimalPlaces)) + "%")
  }
}
