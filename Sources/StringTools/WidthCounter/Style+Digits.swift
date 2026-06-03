//
//  DigitStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

extension WidthCounter {
  /// Generates a two-line digit counter for the configured width.
  public func generateDigitCounter() -> (tens: String, ones: String) {
    
    let startingNumber: Int = 1
    let totalWidth = width + 1  // To make up for starting from 1
    
    // MARK: - The tens digit
    
    var tensLine = ""
    
    for integer in startingNumber..<totalWidth {
      
      // Divide by ten, then take the remainder to get the tens digit.
      let dividedByTen: Int = integer / 10
      let remainder: Int = dividedByTen % 10
      
      tensLine += String(remainder)
      
    }
    
    // MARK: - The ones digit
    
    // Second line: count up by one.
    var onesLine = ""
    for integer in startingNumber..<totalWidth {
      onesLine += String(integer % 10)
    }
    
    guard tensLine.count == width,
          onesLine.count == width
    else { fatalError("Incorrect width calculation somewhere.") }
    
    return (tensLine, onesLine)
    
  }
}
