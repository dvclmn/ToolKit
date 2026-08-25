//
//  CGSize+Checks.swift
//  ToolKit
//
//  Created by Dave Coleman on 25/8/2026.
//

import Foundation

extension CGSize {

  public var hasValidValue: Bool {
    return !isNan && isFinite
  }

  /// Returns true if both dimensions are finite
  public var isFinite: Bool {
    width.isFinite && height.isFinite
  }

  /// Returns true if either dimension is NaN
  public var isNan: Bool {
    return width.isNaN || height.isNaN
  }

  public var isFiniteAndPositive: Bool {
    width.isFiniteAndPositive && height.isFiniteAndPositive
  }

  /// Returns true if both width and height are greater than zero
  public var isGreaterThanZero: Bool {
    width.isGreaterThanZero && height.isGreaterThanZero
  }

  /// Returns true if both width and height is zero
  public var isZero: Bool { width == 0 && height == 0 }

  /// Returns true if both width and height are greater than or equal to zero
  public var isGreaterThanOrEqualToZero: Bool {
    width >= 0 && height >= 0
  }

  /// Returns true if either width or height is zero or negative
  public var isLessThanOrEqualToZero: Bool {
    width <= 0 && height <= 0
  }
}
