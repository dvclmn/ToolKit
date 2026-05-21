//
//  Range.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/5/2026.
//

extension Range {
  public var isZero: Bool { lowerBound == upperBound }
  public var isGreaterThanZero: Bool { lowerBound < upperBound }
  public var isGreaterThanOrEqualToZero: Bool { lowerBound <= upperBound }
}
