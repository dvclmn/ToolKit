//
//  String+Reflow.swift
//  StringTools
//
//  Created by Dave Coleman on 14/9/2024.
//

import Foundation

/// Optional padding inserted before and after a reflowed line.
public enum PaddingBookend {
  case none
  case both(width: Int)
}

/// Reflows text into fixed-width lines.
public struct TextReflow {
  /// Controls how words are separated before wrapping.
  public enum WordBoundaryStrategy: Sendable, Hashable {
    /// Treat any `Character.isWhitespace` value as a word separator and
    /// normalise separator runs to a single output space.
    case allWhitespace
    
    /// Preserve the previous behaviour: split only on literal spaces and keep
    /// repeated spaces in the output.
    case literalSpacesPreservingRuns
  }
  
  let text: String
  let shouldHyphenate: Bool
  let wordBoundaryStrategy: WordBoundaryStrategy

  /// Width for text only. Do not include space for padding or surrounding
  /// structure; handle those elsewhere.
  let width: Int

  /// Used to fill empty space at the end of lines, so that
  /// each line ends up the same length.
  /// Usually a space character, so it is unseen.
  let paddingCharacter: Character

  public init(
    _ text: String,
    width: Int = 20,
    paddingCharacter: Character = " ",
    shouldHyphenate: Bool = true,
    wordBoundaryStrategy: WordBoundaryStrategy = .allWhitespace,
  ) {
    self.text = text
    self.shouldHyphenate = shouldHyphenate
    self.wordBoundaryStrategy = wordBoundaryStrategy
    self.width = width
    self.paddingCharacter = paddingCharacter
  }
}

extension TextReflow {

  /// Reflows the text into padded lines.
  public func reflowed(maxLines: Int = 0) -> [String] {

    guard width > 0 else {
      print("Error: Width must be positive")
      return []
    }

    let paragraphs = text.components(separatedBy: .newlines)
    var reflowedLines: [String] = []

    for paragraph in paragraphs {
      if paragraph.isEmpty {
        reflowedLines.append(String(repeating: paddingCharacter, count: width))
        continue
      }

      // Preserve leading whitespace.
      let leadingWhitespace = paragraph.prefix(while: { $0.isWhitespace })
      let trimmedParagraph = paragraph.dropFirst(leadingWhitespace.count)

      let words = words(in: trimmedParagraph)
      var currentLine = String(leadingWhitespace)

      for word in words {
        let wordString = String(word)

        if currentLine == String(leadingWhitespace) && (currentLine.count + wordString.count) <= width {
          currentLine += wordString
        } else if currentLine.count + wordString.count + 1 <= width {
          if !currentLine.isEmpty && currentLine != String(leadingWhitespace) {
            currentLine += " "
          }
          currentLine += wordString
        } else {

          reflowedLines.append(
            padLine(currentLine, bookends: .none)
          )

          // Handle words exceeding the configured width.
          if wordString.count > width {
            let wrappedWords = wrapLongWord(
              wordString,
              width: width
            )

            reflowedLines.append(
              contentsOf: wrappedWords.dropLast().map {
                padLine($0, bookends: .none)
              })
            currentLine = wrappedWords.last ?? ""
          } else {
            currentLine = String(leadingWhitespace) + wordString
          }
        }
      }

      if !currentLine.isEmpty {
        reflowedLines.append(
          padLine(currentLine, bookends: .none)
        )
      }
    }

    if maxLines > 0 {
      reflowedLines = Array(reflowedLines.prefix(maxLines))
    }

    return reflowedLines
  }

  private func words(in text: Substring) -> [Substring] {
    switch wordBoundaryStrategy {
      case .allWhitespace:
        text.split(omittingEmptySubsequences: true, whereSeparator: \.isWhitespace)
      case .literalSpacesPreservingRuns:
        text.split(separator: " ", omittingEmptySubsequences: false)
    }
  }
  
  private func wrapLongWord(
    _ word: String,
    width: Int,
  ) -> [String] {
    var wrappedWords: [String] = []
    var remainingWord = word

    while !remainingWord.isEmpty {
      if remainingWord.count <= width {
        wrappedWords.append(remainingWord)
        break
      }
      let splitIndex = width - (shouldHyphenate ? 1 : 0)
      let hyphenIfNeeded = shouldHyphenate ? "-" : ""
      let line = remainingWord.prefix(splitIndex) + hyphenIfNeeded
      wrappedWords.append(String(line))
      remainingWord = String(remainingWord.dropFirst(splitIndex))
    }

    return wrappedWords
  }

  func padLine(_ line: String, bookends: PaddingBookend = .none) -> String {

    // Start with current line content.
    var result: String = line

    switch bookends {
      case .both(let bookendWidth):
        let bookendPadding = String(repeating: paddingCharacter, count: bookendWidth)
        result = bookendPadding + result + bookendPadding
      case .none:
        break
    }

    let remainingWidth = max(0, width - result.count)
    result += String(repeating: paddingCharacter, count: remainingWidth)

    return result

  }
}
