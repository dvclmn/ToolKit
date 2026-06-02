//
//  PrintMissing.swift
//  ToolKit
//
//  Created by Dave Coleman on 26/4/2026.
//

import Foundation

/// Prints a standard missing-value diagnostic.
@_spi(Internal) public func printMissing(_ value: String, for consumer: String) {
  print("`\(value)` missing, needed by `\(consumer)`")
}

/// Prints a diagnostic message with the current debug timestamp appended.
@_spi(Internal) public func printTimestamped(_ message: String) {
  let value = message + " at \(Date.debug)"
  print(value)
}

/// Prints a standard expectation-failure diagnostic.
@_spi(Internal) public func printDidNotSatisfy(
  _ value: String,
  expectation: String,
  for consumer: String,
) {
  print("`\(value)` did not match expected result `\(expectation)`, in method `\(consumer)`")
}

@_spi(Internal) public func printPadded(
  _ items: Any...,
  separator: String = " ",
  withTimestamp: Bool = true,
) {
  let adjustedMessage = "\(items)\n\n"
  guard withTimestamp else {
    print(adjustedMessage, separator: separator)
    return
  }
  
  print("(\(Date.debug)) " + adjustedMessage, separator: separator)
}
