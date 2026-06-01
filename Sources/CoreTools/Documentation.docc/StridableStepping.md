# Stridable Stepping

Use CoreTools stepping helpers to advance `Strideable` values while keeping the
result inside a closed range.

## Overview

The helpers return a new value rather than mutating in place. They clamp the
result to the supplied range and can report when the value actually changed.

```swift
var counter = 5
counter = counter.stepping(by: 2, in: 0...10)
// counter == 7

counter = counter.steppingDown(by: 3, in: 0...10)
// counter == 4
```

Use the callback when a UI or model layer needs to react only to real changes:

```swift
var temperature = 20.5
temperature = temperature.stepping(by: 0.5, in: -10.0...30.0) { oldValue, newValue in
  print("Temperature changed from \(oldValue) to \(newValue)")
}
```

You can also test whether a step would remain inside the range before applying
it:

```swift
let value = 95
let canIncrement = value.canStep(by: 10, in: 0...100)
let canIncrementFurther = value.canStep(by: 20, in: 0...100)
```
