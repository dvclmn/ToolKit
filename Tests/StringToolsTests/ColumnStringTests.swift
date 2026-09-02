//
//  ColumnStringTests.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/9/2026.
//

import StringTools
import Testing

struct ColumnStringTests {
  @Test
  func intrinsicWidthPreservesSourceContent() {
    let content = ColumnString(content: "Select")

    #expect(content.width == .intrinsic)
    #expect(content.resolvedColumnCount == 6)
    #expect(content.resolvedContent == "Select")
  }

  @Test
  func fixedWidthPadsUsingTheSelectedAlignment() {
    #expect(ColumnString(content: "7", width: .fixed(3)).resolvedContent == "  7")
    #expect(
      ColumnString(
        content: "7",
        width: .fixed(3),
        alignment: .leading,
      ).resolvedContent == "7  "
    )
    #expect(
      ColumnString(
        content: "7",
        width: .fixed(4),
        alignment: .centre,
      ).resolvedContent == " 7  "
    )
  }

  @Test
  func fixedWidthTruncatesUsingTheSelectedStyle() {
    #expect(ColumnString(content: "abcdef", width: .fixed(4)).resolvedContent == "abc…")
    #expect(
      ColumnString(
        content: "abcdef",
        width: .fixed(4),
        truncationStyle: .start,
      ).resolvedContent == "…def"
    )
    #expect(
      ColumnString(
        content: "abcdef",
        width: .fixed(4),
        truncationStyle: .middle,
      ).resolvedContent == "ab…f"
    )
  }

  @Test
  func flexibleWidthFollowsContentWithinItsBounds() {
    let short = ColumnString(
      content: "7",
      width: .flexible(min: 2, max: 4),
    )
    let fitting = ColumnString(
      content: "123",
      width: .flexible(min: 2, max: 4),
    )
    let long = ColumnString(
      content: "12345",
      width: .flexible(min: 2, max: 4),
    )

    #expect(short.resolvedColumnCount == 2)
    #expect(short.resolvedContent == " 7")
    #expect(fitting.resolvedColumnCount == 3)
    #expect(fitting.resolvedContent == "123")
    #expect(long.resolvedColumnCount == 4)
    #expect(long.resolvedContent == "123…")
  }

  @Test
  func invalidWidthsResolveWithoutTrapping() {
    #expect(ColumnString(content: "abc", width: .fixed(-1)).resolvedContent == "")
    #expect(
      ColumnString(
        content: "abcdef",
        width: .flexible(min: 4, max: 2),
      ).resolvedContent == "abc…"
    )
  }

  @Test
  func widthCountsExtendedGraphemeClusters() {
    let content = ColumnString(
      content: "A👨‍👩‍👧B",
      width: .fixed(2),
    )

    #expect(content.resolvedContent == "A…")
    #expect(content.resolvedContent.count == 2)
  }

  @Test
  func stringLiteralUsesTheDocumentedDefaults() {
    let content: ColumnString = "7"

    #expect(content.sourceContent == "7")
    #expect(content.width == .default)
    #expect(content.alignment == .trailing)
    #expect(content.truncationStyle == .end)
    #expect(content.resolvedContent == "7")
  }
}
