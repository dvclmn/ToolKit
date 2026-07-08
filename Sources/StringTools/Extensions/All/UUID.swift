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

  /// Returns the first 8 characters of the UUID string (the entire first block).
  ///
  /// Usage:
  /// ```
  /// let waveID = UUID()
  /// print(waveID.uuidString) // "E621E1F8-ED6E-464A-A925-1C9503EECEF3"
  /// print(waveID.shortStyle) // "E621E1F8"
  /// ```
  public var shortDisplayID: String {
    return String(self.uuidString.prefix(8))
  }

}
