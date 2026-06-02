//
//  CaseCyclable.swift
//  ToolKit
//
//  Created by Dave Coleman on 7/10/2025.
//

import Foundation

/// A case-iterable value that can move to its neighbouring case.
public protocol CaseCyclable: CaseIterable, Equatable, Sendable where AllCases: RandomAccessCollection {
  static var defaultCase: Self { get }
}

extension CaseCyclable {
  /// Returns the next case, optionally wrapping from the last case to the first.
  public func toNext(wrapping: Bool = true) -> Self {
    guard let currentIndex else { return Self.defaultCase }
    guard let nextIndex = cases.nextIndex(after: currentIndex, wrapping: wrapping) else {
      return self
    }
    return cases[nextIndex]
  }

  /// Returns the previous case, optionally wrapping from the first case to the last.
  public func toPrevious(wrapping: Bool = true) -> Self {
    guard let currentIndex else { return Self.defaultCase }
    guard let previousIndex = cases.previousIndex(before: currentIndex, wrapping: wrapping) else {
      return self
    }
    return cases[previousIndex]
  }

  private var currentIndex: Self.AllCases.Index? {
    Self.allCases.firstIndex(of: self)
  }

  private var cases: Self.AllCases { Self.allCases }

}

extension CaseCyclable {
  public var isAtBeginning: Bool { self == Self.allCases.first }
  public var isAtEnd: Bool { self == Self.allCases.last }

  /// Mutates the value to its next case.
  public mutating func next(wrapping: Bool = true) { self = toNext(wrapping: wrapping) }

  /// Mutates the value to its previous case.
  public mutating func previous(wrapping: Bool = true) { self = toPrevious(wrapping: wrapping) }
}
