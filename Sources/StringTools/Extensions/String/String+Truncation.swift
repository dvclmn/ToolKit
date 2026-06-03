//
//  String+Truncation.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/11/2025.
//

import Foundation

/// Where an ellipsis should be inserted when truncating text.
public enum TruncationStyle {
  /// Keep the end of the string and place the ellipsis at the start.
  case start
  
  /// Keep the start and end of the string and place the ellipsis between them.
  case middle
  
  /// Keep the start of the string and place the ellipsis at the end.
  case end
}

extension String {
  /// Truncates a string to a maximum length using the specified truncation style.
  ///
  /// The ellipsis does not count towards `maxLength`, so the returned string
  /// may be longer than `maxLength` by the length of the ellipsis.
  ///
  /// - Parameters:
  ///   - maxLength: Maximum number of content characters to show.
  ///   - ellipsis: The marker inserted where text has been omitted.
  ///   - style: Where the ellipsis should be inserted.
  ///   - emptyPlaceholder: Text to show when the string is empty.
  /// - Returns: A truncated string, or the original string if no truncation is needed.
  public func truncate(
    to maxLength: Int = 20,
    ellipsis: String = "…",
    style: TruncationStyle = .middle,
    emptyPlaceholder: String? = "(Empty)"
  ) -> String {

    // Handle empty string.
    guard !self.isEmpty else { return emptyPlaceholder ?? self }

    // Ensure minimum length for meaningful truncation.
    let minLength = 2
    let effectiveMaxLength = max(minLength, maxLength)

    // If string is short enough, return as-is.
    guard self.count > effectiveMaxLength else { return self }

    switch style {
      case .start:
        let suffix = String(self.suffix(effectiveMaxLength))
        return "\(ellipsis)\(suffix)"

      case .middle:
        let prefixLength = effectiveMaxLength / 2
        let suffixLength = effectiveMaxLength - prefixLength
        let prefix = String(self.prefix(prefixLength))
        let suffix = String(self.suffix(suffixLength))
        return "\(prefix)\(ellipsis)\(suffix)"

      case .end:
        let prefix = String(self.prefix(effectiveMaxLength))
        return "\(prefix)\(ellipsis)"
    }
  }

  /// Wraps text in decorative dividers for display purposes.
  public func wrappedInDividers() -> String {
    return "\n---\n\(self)\n---\n"
  }
}
