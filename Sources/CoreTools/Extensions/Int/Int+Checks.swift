//
//  Int+Checks.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/8/2026.
//

extension Int {

  /// A Boolean value indicating whether the integer is even.
  public var isEven: Bool { self % 2 == 0 }
  public var isPositive: Bool { self > 0 }

  public func isWithin(_ collection: some Collection) -> Bool {
    let startIndex = collection.startIndex
    let endIndex = collection.endIndex
    guard let index = collection.index(startIndex, offsetBy: self, limitedBy: endIndex) else {
      return false
    }
    return index < endIndex
  }

  public func isWithin(_ range: ClosedRange<Int>, isInclusive: Bool = true) -> Bool {
    guard isInclusive else {
      return self > range.lowerBound && self < range.upperBound
    }
    return self >= range.lowerBound && self <= (range.upperBound - 1)
  }

}
