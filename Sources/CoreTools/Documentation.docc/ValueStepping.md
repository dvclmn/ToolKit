# Value Stepping

Step through exact collection positions or sorted sets of allowed values,
including cases where the current value is between two allowed entries.

## Overview

Use the exact stepping helpers when the current value is already in the collection
and the collection's existing order matters. Use the loose helpers when the value
may sit between allowed values, such as a font size or zoom level controlled by
predefined stops. Loose helpers compare allowed values in sorted order.

```swift
import CoreGraphics

let sizes: [CGFloat] = [9, 12, 16, 24, 36]
let current: CGFloat = 18

let next = current.steppedLoosely(in: sizes, direction: .up)
// next == 24

let previous = current.steppedLoosely(in: sizes, direction: .down)
// previous == 16
```

Collections can perform the same lookup directly:

```swift
let values = [10, 20, 30]

let exactNext = values.nextElement(after: 20, wrapping: false)
let looseNext = values.nextValueLoosely(after: 25)
```

Pass `wrapping: true` when stepping beyond the edge should continue from the
other end of the collection.

## Topics

### Direction

- ``StepDirection``
