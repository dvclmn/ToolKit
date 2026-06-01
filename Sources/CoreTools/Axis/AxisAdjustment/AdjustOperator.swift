//
//  AdjustOperator.swift
//  ToolKit
//
//  Created by Dave Coleman on 20/1/2026.
//

prefix operator *

/// A unary operation built by the adjustment prefix operators.
public struct Operation<T> {
  let apply: (T) -> T
}

/// Creates an operation that adds `rhs` to a floating-point value.
public prefix func + <T: BinaryFloatingPoint>(rhs: T) -> Operation<T> {
  Operation { $0 + rhs }
}

/// Creates an operation that adds `rhs` to an additive value.
public prefix func + <T: AdditiveArithmetic>(rhs: T) -> Operation<T> {
  Operation { $0 + rhs }
}

/// Creates an operation that multiplies a numeric value by `rhs`.
public prefix func * <T: Numeric>(rhs: T) -> Operation<T> {
  Operation { $0 * rhs }
}
