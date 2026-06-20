//
//  ClosedRange+Conversions.swift
//  ToolKit
//
//  Created by Dave Coleman on 20/6/2026.
//

import Foundation

extension ClosedRange where Bound == Double {
  public var toCGFloatRange: ClosedRange<CGFloat> {
    CGFloat(lowerBound)...CGFloat(upperBound)
  }
}

extension ClosedRange where Bound == Int {
  public var toDoubleRange: ClosedRange<Double> {
    Double(lowerBound)...CGFloat(upperBound)
  }
  public var toCGFloatRange: ClosedRange<CGFloat> {
    CGFloat(lowerBound)...CGFloat(upperBound)
  }
  public func toBinaryFloatingPointRange<T: BinaryFloatingPoint>() -> ClosedRange<T> {
    T(lowerBound)...T(upperBound)
  }
}

extension ClosedRange where Bound: BinaryFloatingPoint & Sendable {
  public var toCGFloatRange: ClosedRange<CGFloat> {
    CGFloat(lowerBound)...CGFloat(upperBound)
  }
  public var toDoubleRange: ClosedRange<Double> {
    Double(lowerBound)...Double(upperBound)
  }
  public var toIntRange: ClosedRange<Int> {
    Int(lowerBound)...Int(upperBound)
  }
}
