//
//  Binding+Float.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/6/2026.
//

import SwiftUI

extension BinaryFloatingPoint where Self: Sendable {
  public var toBindingCGFloat: CGFloat {
    get { CGFloat(self) }
    set { self = Self(newValue) }
  }

  public var toBindingDouble: Double {
    get { Double(self) }
    set { self = Self(newValue) }
  }
  //    Binding<Double>(
  //      get: { Double(wrappedValue) },
  //      set: { wrappedValue = Value($0) },
  //    )

}

//extension Binding where Value: BinaryFloatingPoint & Sendable {
//  public var toBindingCGFloat: Binding<CGFloat> {
//    Binding<CGFloat>(
//      get: { CGFloat(wrappedValue) },
//      set: { wrappedValue = Value($0) },
//    )
//  }
//  public var toBindingDouble: Binding<Double> {
//    Binding<Double>(
//      get: { Double(wrappedValue) },
//      set: { wrappedValue = Value($0) },
//    )
//  }
//}

extension Binding where Value == Int {
  /// Convert `Int` Binding to `Double` Binding
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = Value($0) },
    )
  }
  /// Convert `Int` Binding to `Double` Binding
  public var toBindingCGFloat: Binding<CGFloat> {
    Binding<CGFloat>(
      get: { CGFloat(wrappedValue) },
      set: { wrappedValue = Value($0) },
    )
  }

  /// Convert `Int` Binding to `Double` Binding
  public func toBindingBinaryFloatingPoint<T: BinaryFloatingPoint & Sendable>() -> Binding<T> {
    Binding<T>(
      get: { T(wrappedValue) },
      set: { wrappedValue = Value($0) },
    )
  }
}

extension Binding where Value == ClosedRange<Int> {
  public func toBindingBinaryFloatingPointRange<T: BinaryFloatingPoint & Sendable>() -> Binding<
    ClosedRange<T>
  > {
    Binding<ClosedRange<T>>(
      get: { wrappedValue.toBinaryFloatingPointRange() },
      set: { wrappedValue = $0.toIntRange },
    )
  }
}
