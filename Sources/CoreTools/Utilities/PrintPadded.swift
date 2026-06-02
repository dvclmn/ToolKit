//
//  PrintPadded.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/9/2025.
//

import Foundation

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
