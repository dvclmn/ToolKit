# Range Debugging

Convert between Swift string ranges, attributed-string ranges, and `NSRange`
values while keeping debug output readable.

## Overview

StringTools includes small conversion helpers for APIs that need different range
representations. Use them when moving between Swift-native string operations,
Foundation regular expressions, AppKit text APIs, and attributed strings.

```swift
let text = "A width of 120 appears here"
let range = text.range(of: "120")!

let nsRange = range.toNSRange(in: text)
let preview = range.debugPreview(in: text, captureName: "width")
```

The collection `indexRange` helper is useful with regex captures, where a
capture exposes indices rather than a concrete `Range`:

```swift
let range = Range(match.output.1.indices)
```
