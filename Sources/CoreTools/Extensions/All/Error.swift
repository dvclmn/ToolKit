//
//  Error.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/9/2025.
//

import Foundation

extension DecodingError {
  package var name: String {
    switch self {
      case .typeMismatch(let type, _): "Type Mismatch. Expected Type: `\(type)`"
      case .valueNotFound(let type, _): "Value not Found. Expected Type: `\(type)`"
      case .keyNotFound(let key, _): "Key `\(key)` not Found"
      case .dataCorrupted(_): "Data Corrupted"
      default: "Unknown Decoding Error"
    }
  }
}

extension DecodingError.Context {
  package var name: String {
    return """
      Decoding Error Context:
      Coding Path: \(self.codingPath)
      Debug Desc.: \(self.debugDescription)
      underlying Error: \(self.underlyingError?.localizedDescription ?? "N/A")
      """
  }
}
