//
//  NSTextView.swift
//  ToolKit
//
//  Created by Dave Coleman on 16/11/2025.
//

#if canImport(AppKit)
import AppKit

extension NSTextView {

  public func setInsets(_ size: CGSize) {
    self.textContainer?.lineFragmentPadding = size.width
    self.textContainerInset = NSSize(
      width: 0,
      height: size.height,
    )
  }

  /// Get the full bounds of the current text.
  public var documentNSRange: NSRange {
    NSRange(location: 0, length: textStorage?.length ?? 0)
  }

  public var documentRange: NSTextRange? { self.textLayoutManager?.documentRange }
  public var nsString: NSString { string as NSString }
  public var documentLength: Int { nsString.length }

  /// Returns the selected range expanded to the containing paragraph.
  public var safeCurrentParagraphRange: NSRange {
    // Get the safe selection first.
    let safeSelection = safeSelectedRange

    // `NSString.paragraphRange` always returns a valid range within string
    // bounds if the input is valid, so no secondary clamping is required here.
    return nsString.paragraphRange(for: safeSelection)
  }

  /// Uses `NSIntersectionRange` to strictly enforce bounds.
  public func getSafeRange(for range: NSRange) -> NSRange {
    NSIntersectionRange(range, documentNSRange)
  }

  public var safeSelectedRange: NSRange {
    getSafeRange(for: selectedRange)
  }

  public func string(for range: NSRange) -> String? {
    guard textStorage != nil else { return nil }

    // Reuse the centralised safety check.
    let validRange = getSafeRange(for: range)

    // Handle empty ranges, such as a caret position, gracefully.
    return nsString.substring(with: validRange)
  }

  public func boundingRect(
    for range: NSRange,
    lm layoutManager: NSLayoutManager,
    tc textContainer: NSTextContainer,

  ) -> CGRect {
    let glyphRange = layoutManager.glyphRange(
      forCharacterRange: range,
      actualCharacterRange: nil,
    )

    // Get the bounding rect for this glyph range.
    let boundingRect = layoutManager.boundingRect(
      forGlyphRange: glyphRange,
      in: textContainer,
    )

    return boundingRect
  }

  /// Converts an NSRange to an NSTextRange for the current content manager
  public func textRange(for range: NSRange) -> NSTextRange? {
    guard let tcm = self.textLayoutManager?.textContentManager else { return nil }
    return tcm.textRange(for: range)
  }

  /// TextKit 2 equivalent of boundingRect(forGlyphRange:...)
  public func boundingRect(for textRange: NSTextRange) -> CGRect {
    guard let textLayoutManager = self.textLayoutManager else { return .zero }

    var unionRect: CGRect = .null

    // `.standard` includes the visible glyphs. Use `.selection` or
    // `.highlight` to encompass the full line height/advance.
    textLayoutManager.enumerateTextSegments(
      in: textRange,
      type: .standard,
      options: [],
    ) {
      segmentRange, rect, baseline, textContainer in

      // The rect is provided in the text container's coordinate system.
      // Translate it to the text view's coordinate system.
      var viewRect = rect
      viewRect.origin.x += self.textContainerOrigin.x
      viewRect.origin.y += self.textContainerOrigin.y

      unionRect = unionRect.union(viewRect)

      return true  // Continue enumeration
    }

    return unionRect.isNull ? .zero : unionRect
  }
}
#endif
