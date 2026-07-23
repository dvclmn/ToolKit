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
}

extension Int {
  /// Convert `Int` to a writable `Double` projection for use as
  /// `$integer.toBindingDouble`.
  public var toBindingDouble: Double {
    get { Double(self) }
    set { self = Int(newValue) }
  }

  /// Convert `Int` to a writable `CGFloat` projection for use as
  /// `$integer.toBindingCGFloat`.
  public var toBindingCGFloat: CGFloat {
    get { CGFloat(self) }
    set { self = Int(newValue) }
  }

}

extension ClosedRange where Bound == Int {
  /// Converts this range to a writable `Double` projection for use as
  /// `$range.toBindingDoubleRange`.
  public var toBindingDoubleRange: ClosedRange<Double> {
    get { Double(lowerBound)...Double(upperBound) }
    set { self = Int(newValue.lowerBound)...Int(newValue.upperBound) }
  }

  /// Converts this range to a writable `CGFloat` projection for use as
  /// `$range.toBindingCGFloatRange`.
  public var toBindingCGFloatRange: ClosedRange<CGFloat> {
    get { CGFloat(lowerBound)...CGFloat(upperBound) }
    set { self = Int(newValue.lowerBound)...Int(newValue.upperBound) }
  }
}
