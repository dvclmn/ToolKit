# String Formatting

Split, truncate, pad, and pluralise text with small value-driven helpers.

## Overview

Use ``OmissionStrategy`` when splitting line-oriented text and you need explicit
control over empty lines. Use ``SplitConfig`` for separator-based fields where
trimming and trailing-empty-field behaviour matter.

```swift
let cells = " name | value | ".split(using: SplitConfig(
  separator: "|",
  emptyPolicy: .semantic
))
// ["name", "value"]

let lines = "A\nB\n".lines(omissionStrategy: .omitLastLineIfEmpty)
// ["A", "B"]
```

Truncation keeps the content length separate from the ellipsis length:

```swift
"Hello World".truncate(to: 8, style: .middle)
// "Hell…orld"

"Hello World".truncate(to: 8, style: .end)
// "Hello Wo…"
```

For fixed-width output, use ``LinePadOptions`` when the string needs caps,
bookend spacing, split gaps, or an explicit odd-padding strategy.

## Topics

### Splitting

- ``OmissionStrategy``
- ``SplitConfig``
- ``EmptyFieldPolicy``
- ``TrailingPolicy``

### Truncation

- ``TruncationStyle``

### Padding

- ``LinePadOptions``
- ``LineCaps``
- ``TextPadAlignment``
- ``OddPaddingPolicy``
- ``SurroundSpaces``

### Pluralisation

- ``CountStrategy``
