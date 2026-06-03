//
//  Pluraliser.swift
//  StringTools
//
//  Created by Dave Coleman on 24/9/2024.
//

import Foundation

/// Controls whether a pluralised phrase includes its numeric count.
public enum CountStrategy {
  /// Include the count, optionally including it when the count is one.
  case showCount(evenForSingle: Bool = false)
  
  /// Return only the singular or plural word.
  case hideCount
}

/// Returns the singular or plural form of a noun.
///
/// - Parameters:
///   - noun: The singular noun.
///   - count: The count used to choose singular or plural output.
///   - countStrategy: Whether the numeric count should be included.
///   - irregularPlural: An explicit plural form for irregular nouns.
public func pluralise(
  _ noun: String,
  count: Int,
  countStrategy: CountStrategy = .hideCount,
  irregularPlural: String? = nil
) -> String {

  let pluralForm = irregularPlural ?? noun + "s"
  switch countStrategy {
    case .showCount(let always):
      guard count == 1 else {
        return "\(count) \(pluralForm)"
      }
      return always ? "1 \(noun)" : noun
    case .hideCount:
      return count == 1 ? noun : pluralForm
  }
}

/// Returns the singular or regular plural form of a word.
public func pluralise(
  _ word: String,
  count: Int,
  countStrategy: CountStrategy = .hideCount
) -> String {

  switch countStrategy {
    case .showCount(let shouldDisplayForSingle):
      guard count == 1 else {
        return "\(count) \(word)" + "s"
      }
      return shouldDisplayForSingle ? "\(count) \(word)" : word
    case .hideCount:
      return count == 1 ? word : word + "s"
  }
}
