//
//  Range+Preview.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension Range where Bound == String.Index {
  /// Builds a debug preview for the range, including nearby context.
  package func debugPreview(
    in text: String,
    captureName: String? = nil,
    maxRangePreviewLength: Int? = nil,
    maxContextLength: Int = 30,
    indentCharacter: Character = "│",
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {

    guard !text.isEmpty else { return "Text is empty." }

    // Three main components:
    // - Context (text before the provided range)
    // - Range preview
    // - Context (text after range)

    // Text before
    let beforeIndex =
      text.index(
        lowerBound,
        offsetBy: -maxContextLength,
        limitedBy: text.startIndex
      ) ?? text.startIndex
    let before = String(text[beforeIndex..<lowerBound])
    let hasLeadingTruncation = beforeIndex > text.startIndex

    // Text after
    let afterIndex =
      text.index(
        upperBound,
        offsetBy: maxContextLength,
        limitedBy: text.endIndex
      ) ?? text.endIndex
    let after = String(text[upperBound..<afterIndex])
    let hasTrailingTruncation = afterIndex < text.endIndex


    // Range preview
    let rangeRawText = String(text[self])
    let rangeCharacterCount = rangeRawText.count
    
    var rangePreview: String
    if let maxRangePreviewLength {
      rangePreview = rangeRawText.truncate(to: maxRangePreviewLength, style: .middle)
    } else {
      rangePreview = rangeRawText
    }
    
    // Range Capture name
    let captureNameText: String
    if let captureName {
      captureNameText = "<\(captureName)>"
    } else {
      captureNameText = ""
    }
    
    let highlightedRange = captureNameText + highlight(rangePreview)

    let trunc = "[…]"
    let truncLeading: String? = hasLeadingTruncation ? trunc : nil
    let truncTrailing: String? = hasTrailingTruncation ? trunc : nil

    let countLabel = pluralise(
      "character",
      count: rangeCharacterCount,
      countStrategy: .showCount(evenForSingle: true)
    )

    // Adds a new line for pleasing text layout.
    let emptyLine = ""

    
    let mainContent = [
      truncLeading,
      before,
      highlightedRange,
      after,
      truncTrailing,
    ].joinedCompact()

    let lines = [
      "String: \"\(rangeRawText)\" (\(countLabel))",
      emptyLine,
      mainContent,
      emptyLine,
    ]

    return lines.joined("\n\(indentCharacter) ")
  }
}
