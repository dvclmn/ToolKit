# Value Stepping

Step through ordered sets of allowed values, including cases where the current
value is between two allowed entries.

## Overview

Use the exact stepping helpers when the current value is already in the
collection. Use the loose helpers when the value may sit between allowed values,
such as a font size or zoom level controlled by predefined stops.

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

let exactNext = values.nextValue(after: 20)
let looseNext = values.nextValueLoosely(after: 25)
```

Pass `wrapping: true` when stepping beyond the edge should continue from the
other end of the collection.

## Topics

### Direction

- ``StepDirection``
