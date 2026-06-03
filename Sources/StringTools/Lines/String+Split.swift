//
//  String+Split.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/11/2025.
//

/// Configuration for splitting a string into normalised `String` values.
public struct SplitConfig {
  public var separator: Character
  public var emptyPolicy: EmptyFieldPolicy = .structuralOnly
  public var trailingPolicy: TrailingPolicy = .keepAll
  public var trimWhitespace: Bool = true

  public init(
    separator: Character,
    emptyPolicy: EmptyFieldPolicy = .structuralOnly,
    trailingPolicy: TrailingPolicy = .keepAll,
    trimWhitespace: Bool = true
  ) {
    self.separator = separator
    self.emptyPolicy = emptyPolicy
    self.trailingPolicy = trailingPolicy
    self.trimWhitespace = trimWhitespace
  }
}

/// Controls how empty fields are handled when splitting text.
public enum EmptyFieldPolicy {
  /// Drop fields that are structurally empty (from `||`, leading/trailing separators).
  case structuralOnly

  /// Drop fields that become empty after trimming/normalising.
  case semantic

  /// Keep everything.
  case keepAll
}

/// Optional post-processing applied after splitting and trimming.
public enum TrailingPolicy {
  /// Keep the final field, even when it is empty.
  case keepAll
  
  /// Drop the final field when it is empty after trimming.
  case dropIfEmptyAfterTrim
}

extension String {
  /// Splits the string using a separator and empty-field policy.
  ///
  /// - Parameters:
  ///   - separator: The character to split on.
  ///   - emptyPolicy: How empty fields should be handled.
  ///   - trailingPolicy: How the final field should be handled.
  ///   - trimWhitespace: Whether to trim whitespace from each field after splitting.
  /// - Returns: The split fields as `String` values.
  public func split(
    at separator: Character,
    emptyPolicy: EmptyFieldPolicy = .structuralOnly,
    trailingPolicy: TrailingPolicy = .keepAll,
    trimWhitespace: Bool = true
  ) -> [String] {
    let config = SplitConfig(
      separator: separator,
      emptyPolicy: emptyPolicy,
      trailingPolicy: trailingPolicy,
      trimWhitespace: trimWhitespace
    )
    return self.split(using: config)
  }
  
  /// Splits the string using a reusable split configuration.
  public func split(
    using config: SplitConfig
  ) -> [String] {
    // 1. Structural split
    let raw = self.split(
      separator: config.separator,
      omittingEmptySubsequences: config.emptyPolicy == .structuralOnly
    )

    // 2. Content normalisation
    var fields = raw.map { substring in
      config.trimWhitespace
        ? substring.trimmingCharacters(in: .whitespaces)
        : String(substring)
    }

    // 3. Semantic filtering
    switch config.emptyPolicy {
      case .semantic:
        fields.removeAll { $0.isEmpty }
      case .structuralOnly, .keepAll:
        break
    }

    // 4. Trailing rule
    if case .dropIfEmptyAfterTrim = config.trailingPolicy {
      if let last = fields.last, last.isEmpty {
        fields.removeLast()
      }
    }

    return fields
  }
}
