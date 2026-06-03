//
//  String+Repeater.swift
//  StringTools
//
//  Created by Dave Coleman on 14/9/2024.
//

@resultBuilder
struct PatternBuilder {
  static func buildBlock(_ components: PatternComponent...) -> [PatternComponent] {
    return components
  }
}

/// A component that can append part of a repeating string pattern.
public protocol PatternComponent {
  func apply(to string: inout String, remainingCount: inout Int)
}

struct PatternForEach: PatternComponent {
  let components: [PatternComponent]

  func apply(to string: inout String, remainingCount: inout Int) {
    for component in components {
      component.apply(to: &string, remainingCount: &remainingCount)
      if remainingCount == 0 { break }
    }
  }
}

/// A repeated character segment in a string pattern.
public struct CharacterPattern: PatternComponent {
  let char: Character
  let count: Int

  /// Applies this character segment to a string while respecting the remaining
  /// output length.
  public func apply(to string: inout String, remainingCount: inout Int) {
    let repeatCount = min(count, remainingCount)
    string += String(repeating: char, count: repeatCount)
    remainingCount -= repeatCount
  }
}

extension String {
  /// Builds a string by repeating pattern components until `totalCount` is
  /// reached.
  public static func pattern(totalCount: Int, @PatternBuilder _ builder: () -> [PatternComponent]) -> String {
    var result = ""
    var remainingCount = totalCount
    let components = builder()

    while remainingCount > 0 {
      for component in components {
        component.apply(to: &result, remainingCount: &remainingCount)
        if remainingCount == 0 { break }
      }
    }

    return result
  }

  /// Creates a string by repeating `(character, count)` pattern segments until
  /// `totalCount` is reached.
  public init(pattern: (Character, Int)..., totalCount: Int) {
    self = String.pattern(totalCount: totalCount) {
      PatternForEach(components: pattern.map { repeating($0.0, count: $0.1) })
    }
  }

  /// A closure that creates an alternating dash-dot string of a requested
  /// length.
  public static var dashDotPattern: (Int) -> String {
    return { count in

      String.pattern(totalCount: count) {
        character("-")
        character(".")
      }
    }
  }
}

func character(_ char: Character) -> PatternComponent {
  return CharacterPattern(char: char, count: 1)
}

func repeating(_ char: Character, count: Int) -> PatternComponent {
  return CharacterPattern(char: char, count: count)
}
