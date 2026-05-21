//
//  ClosedRange.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/5/2026.
//

extension ClosedRange where Bound: BinaryFloatingPoint {
  public static var phaseRange: Self { 0...1 * .pi }
  public static var unitRange: Self { 0...1 }
}

extension ClosedRange {
  public var isZero: Bool { lowerBound == upperBound }
  public var isGreaterThanZero: Bool { lowerBound < upperBound }
  public var isGreaterThanOrEqualToZero: Bool { lowerBound <= upperBound }
}
