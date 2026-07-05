//
//  UUID.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/7/2026.
//

import Foundation

extension UUID {
  public var truncated: String {
    uuidString.truncate(to: 8, style: .middle)
  }
}
