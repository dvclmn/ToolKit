//
//  Model+HSVModifier.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/8/2025.
//

import Foundation

public protocol HSVModifier {
  var adjustment: HSVAdjustment { get }
}

extension Array where Element == HSVAdjustment {

  /// Combines adjustments with a strength multiplier
  public func combined(with strength: Double) -> HSVAdjustment {
    guard !isEmpty else { return .noAdjustment }
    let weighted = self.map { $0.scaled(by: strength) }
    return weighted.reduce(.noAdjustment, +)
  }
  //  public func combined(with strength: Double) -> HSVAdjustment {
  //    guard !isEmpty else { return .zero }
  //
  //    /// Apply strength to each adjustment, then combine them
  //    let weightedAdjustments = self.map { adjustment in
  //      HSVAdjustment.zero.interpolated(towards: adjustment)
  //    }
  //    return weightedAdjustments.reduce(.zero, +)
  //  }
}

extension Optional where Wrapped: BinaryFloatingPoint {

  /// Applies an operation to two optional floats, treating nil as zero
  public func combined(
    with other: Wrapped?,
    using operation: (Wrapped, Wrapped) -> Wrapped,
  ) -> Wrapped? {
    guard self != nil || other != nil else { return nil }

    let lhs = self ?? .zero
    let rhs = other ?? .zero
    return operation(lhs, rhs)
  }

  private func withDefault(_ defaultValue: Wrapped) -> Wrapped {
    return self ?? defaultValue
  }
}
