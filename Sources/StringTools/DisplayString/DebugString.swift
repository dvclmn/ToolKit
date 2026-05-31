//
//  DebugString.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation
@_spi(Internal) import CoreTools

package func DebugString(
  _ title: String? = nil,
  indented: Bool = false,
  timestamped: Bool = false,
  @DisplayStringBuilder _ content: () -> [DisplayBlock],
) {
  print(
    DisplayString {
      if indented {
        Indented(title, content: content)
      } else {
        content()
      }
      timestamped ? "\(Date.debug) " : ""
      "\n"
    }.text
  )
}


