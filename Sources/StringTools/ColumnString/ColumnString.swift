//
//  ColumnString.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/3/2026.
//

/// A string that can optionally be resolved to a character-column width.
///
/// `ColumnString` counts extended grapheme clusters, matching `String.count`.
/// It is intended for single-line, plain-text output such as tables, logs, and
/// copied values. A visual interface should use ``sourceContent`` together with
/// ``resolvedColumnCount`` so its layout can measure the active font rather
/// than relying on inserted spaces.
public struct ColumnString: Sendable, Equatable, Hashable {
  /// The caller-supplied content before width resolution.
  private let content: String
  
  /// The width behaviour for the column.
  public let width: Width

  /// The alignment used when padding content shorter than its resolved width.
  public let alignment: TextPadAlignment

  /// The truncation used when content exceeds its resolved width.
  public let truncationStyle: TruncationStyle
  
  /// Creates a column string.
  public init(
    content: String,
    width: Width = .default,
    alignment: TextPadAlignment = .trailing,
    truncationStyle: TruncationStyle = .end,
  ) {
    self.content = content
    self.width = width
    self.alignment = alignment
    self.truncationStyle = truncationStyle
  }
}

extension ColumnString {
  /// The caller-supplied content before width resolution.
  public var sourceContent: String { content }

  /// The character-column count selected by ``width`` for ``sourceContent``.
  public var resolvedColumnCount: Int {
    width.resolvedColumnCount(for: content.count)
  }

  /// The source content, or content padded or truncated to
  /// ``resolvedColumnCount`` characters when a column width is requested.
  public var resolvedContent: String {
    let columnCount = resolvedColumnCount
    let fittedContent = content.truncated(
      toColumnCount: columnCount,
      style: truncationStyle,
    )
    let paddingCount = columnCount - fittedContent.count

    guard paddingCount > 0 else { return fittedContent }

    let (leadingPadding, trailingPadding): (Int, Int) =
      switch alignment {
        case .leading:
          (0, paddingCount)
        case .centre:
          (paddingCount / 2, paddingCount - (paddingCount / 2))
        case .trailing:
          (paddingCount, 0)
      }

    return String(repeating: " ", count: leadingPadding)
      + fittedContent
      + String(repeating: " ", count: trailingPadding)
  }
}

extension ColumnString: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(content: value)
  }
}

extension ColumnString {
  /// Character-width behaviour for a column string.
  public enum Width: Sendable, Equatable, Hashable {
    /// Preserve the source content without imposing a character-column width.
    case intrinsic

    /// Resolve to exactly the supplied number of character columns.
    case fixed(Int)
    
    /// Follow the content width within the supplied inclusive bounds.
    case flexible(min: Int = 2, max: Int = Int.max)
    
    public static let `default`: Self = .intrinsic

    /// Resolves the number of character columns for a content length.
    ///
    /// Negative bounds resolve as zero. If a flexible maximum is lower than
    /// its minimum, the minimum takes precedence.
    public func resolvedColumnCount(for contentLength: Int) -> Int {
      let contentLength = Swift.max(0, contentLength)

      switch self {
        case .intrinsic:
          return contentLength

        case .fixed(let count):
          return Swift.max(0, count)

        case .flexible(let minimum, let maximum):
          let minimum = Swift.max(0, minimum)
          let maximum = Swift.max(minimum, maximum)
          return Swift.min(Swift.max(contentLength, minimum), maximum)
      }
    }
  }
}

private extension String {
  func truncated(
    toColumnCount columnCount: Int,
    style: TruncationStyle,
  ) -> String {
    guard columnCount > 0 else { return "" }
    guard count > columnCount else { return self }

    let ellipsis = "…"
    guard columnCount > 1 else { return ellipsis }

    let visibleCharacterCount = columnCount - 1

    switch style {
      case .start:
        return ellipsis + String(suffix(visibleCharacterCount))

      case .middle:
        let prefixCount = (visibleCharacterCount + 1) / 2
        let suffixCount = visibleCharacterCount - prefixCount
        return String(prefix(prefixCount))
          + ellipsis
          + String(suffix(suffixCount))

      case .end:
        return String(prefix(visibleCharacterCount)) + ellipsis
    }
  }
}
