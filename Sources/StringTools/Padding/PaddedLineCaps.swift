//
//  PadLine.swift
//  StringTools
//
//  Created by Dave Coleman on 29/8/2024.
//

import Foundation

/// Horizontal alignment used when padding text to a fixed width.
public enum TextPadAlignment: Sendable, Hashable {
  /// Keep the text at the leading edge and add padding after it.
  case leading
  
  /// Centre the text, distributing padding on both sides.
  case centre
  
  /// Keep the text at the trailing edge and add padding before it.
  case trailing
}

/// Controls how odd padding is resolved when centred padding cannot be split
/// evenly.
public enum OddPaddingPolicy: Sendable, Hashable {
  /// Reduce the padding by one character when possible.
  case reduce
  
  /// Expand the padding by one character.
  case expand
  
  /// Leave the uneven padding in place.
  case tolerate
}

/// Optional strings placed at the leading and trailing edges of a padded line.
public struct LineCaps: Sendable, Hashable {
  public var leading: String
  public var trailing: String
  public var padWithSpace: Bool

  public init(_ leading: String, _ trailing: String, padWithSpace: Bool = true) {
    self.leading = leading
    self.trailing = trailing
    self.padWithSpace = padWithSpace
  }
}

/// Options used by `String.paddedLine(_:)`.
public struct LinePadOptions: Sendable, Hashable {
  public var width: Int
  public var pad: Character
  public var alignment: TextPadAlignment
  public var splitOn: Character?
  public var omitEmptySplits: Bool
  public var caps: LineCaps?
  public var surroundSpaces: SurroundSpaces
  public var oddPaddingPolicy: OddPaddingPolicy

  public init(
    width: Int,
    pad: Character = " ",
    alignment: TextPadAlignment = .centre,
    splitOn: Character? = nil,
    omitEmptySplits: Bool = true,
    caps: LineCaps? = nil,
    surroundSpaces: SurroundSpaces = .none,
    oddPaddingPolicy: OddPaddingPolicy = .reduce
  ) {
    self.width = width
    self.pad = pad
    self.alignment = alignment
    self.splitOn = splitOn
    self.omitEmptySplits = omitEmptySplits
    self.caps = caps
    self.surroundSpaces = surroundSpaces
    self.oddPaddingPolicy = oddPaddingPolicy
  }
}

extension String {
  /// Pads a string to a target width, optionally adding caps and distributing
  /// padding around split components.
  ///
  /// If the requested width is too small for the source text, caps, and required
  /// bookend spaces, the original string is returned unchanged.
  public func paddedLine(_ options: LinePadOptions) -> String {
    let width = options.width
    let pad = options.pad

    // Obviously invalid widths cannot be padded usefully.
    if width <= 0 { return self }

    // Build cap strings, including optional cap-adjacent spaces.
    let (capLeading, capTrailing): (String, String) = {
      guard let caps = options.caps else { return ("", "") }
      let spacer = caps.padWithSpace ? " " : ""
      return (caps.leading + spacer, spacer + caps.trailing)
    }()

    // Determine split mode.
    let pieces: [Substring]
    let isSplitMode: Bool
    if let split = options.splitOn, self.contains(split) {
      let parts = self.split(
        separator: split,
        omittingEmptySubsequences: options.omitEmptySplits
      )
      pieces = parts.isEmpty ? [self[...]] : parts
      isSplitMode = pieces.count > 1
    } else {
      pieces = [self[...]]
      isSplitMode = false
    }

    let gaps = max(0, pieces.count - 1)
    let contentWidth = pieces.reduce(0) { $0 + $1.count }

    // Decide surround-space behaviour.
    let wantsWholeBookends: Bool =
      switch options.surroundSpaces {
        case .none, .aroundSplitGaps: false
        case .aroundWholeText, .both: true
      }

    let wantsGapBookends: Bool =
      switch options.surroundSpaces {
        case .none, .aroundWholeText: false
        case .aroundSplitGaps, .both: true
      }

    // Compute the minimum width required before adding pad characters.
    let wholeBookendWidth = (!isSplitMode && wantsWholeBookends) ? 2 : 0
    let gapBookendWidth = (isSplitMode && wantsGapBookends) ? (2 * gaps) : 0

    let minWidth =
      capLeading.count + capTrailing.count
      + contentWidth
      + wholeBookendWidth
      + gapBookendWidth

    if width < minWidth {
      return self
    }

    let availablePadding = width - minWidth

    guard isSplitMode else {

      var effectivePadding = availablePadding
      if options.alignment == .centre && (availablePadding % 2 != 0) {
        switch options.oddPaddingPolicy {
          case .tolerate:
            break  // keep as-is
          case .reduce:
            // Only reduce if we won’t violate the minimum width.
            if effectivePadding > 0 { effectivePadding -= 1 }
          case .expand:
            effectivePadding += 1
        }
      }

      // No split: distribute left/right padding via alignment.
      let (left, right) = distributePadding(options.alignment, padding: effectivePadding)

      return capLeading
        + String(repeating: pad, count: left)
        + (wantsWholeBookends ? " " : "")
        + self
        + (wantsWholeBookends ? " " : "")
        + String(repeating: pad, count: right)
        + capTrailing
    }

    // Distribute padding over gaps.
    let perGap = gaps == 0 ? 0 : (availablePadding / gaps)
    let leftover = gaps == 0 ? 0 : (availablePadding % gaps)

    var out = capLeading

    for (idx, piece) in pieces.enumerated() {
      out += piece

      if idx < gaps {
        let padCount = perGap + (idx < leftover ? 1 : 0)

        if wantsGapBookends { out += " " }
        out += String(repeating: pad, count: padCount)
        if wantsGapBookends { out += " " }
      }
    }

    out += capTrailing
    return out
  }

  private func distributePadding(_ alignment: TextPadAlignment, padding: Int) -> (left: Int, right: Int) {
    switch alignment {
      case .leading: return (0, padding)
      case .trailing: return (padding, 0)
      case .centre:
        let left = padding / 2
        return (left, padding - left)
    }
  }
}
