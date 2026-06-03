//
//  OmissionStrategy.swift
//  ToolKit
//
//  Created by Dave Coleman on 27/2/2026.
//

/// Describes how empty pieces are handled when splitting text into lines or
/// components.
public enum OmissionStrategy {
  
  /// Removes every empty subsequence from the result.
  case omitAllEmpty
  
  /// Preserves empty subsequences, then removes a final empty line if present.
  case omitLastLineIfEmpty
  
  /// Preserves all empty subsequences.
  case doNotOmit
}

extension OmissionStrategy {
  fileprivate var omitsEmptySubsequencesDuringSplit: Bool {
    switch self {
      case .omitAllEmpty: true
      case .omitLastLineIfEmpty, .doNotOmit: false
    }
  }
  
  fileprivate func finalise(_ parts: [Substring]) -> [Substring] {
    switch self {
      case .omitAllEmpty, .doNotOmit:
        return parts
        
      case .omitLastLineIfEmpty:
        guard let last = parts.last, last.isEmpty else { return parts }
        return Array(parts.dropLast())
    }
  }
  
  package func split(
    _ string: String,
    maxSplits: Int = .max,
    whereSeparator isSeparator: (Character) -> Bool
  ) -> [Substring] {
    let parts = string.split(
      maxSplits: maxSplits,
      omittingEmptySubsequences: omitsEmptySubsequencesDuringSplit,
      whereSeparator: isSeparator
    )
    return finalise(parts)
  }
  
  package func split(
    _ string: String,
    maxSplits: Int = .max,
    separator: Character
  ) -> [Substring] {
    split(string, maxSplits: maxSplits, whereSeparator: { $0 == separator })
  }
}
