# Display Strings

Compose debug-friendly text from small renderable blocks.

## Overview

``DisplayString`` is a lightweight tree for text output. Top-level
``DisplayBlock`` values handle labels, indentation, dividers, and plain text,
while ``FloatDisplayFormat`` controls numeric rendering.

```swift
let output = DisplayString(format: .init(decimalPlaces: 1)) {
  Labeled("Size", value: CGSize(width: 120, height: 80))
  Indented("State") {
    Labeled("Enabled", value: true.displayAs(.yesNo))
    Divider()
  }
}

let text = output.text
```

Composite geometry values conform to ``FloatComponentsLabeled`` so they can
render as labelled numeric components. Use ``DisplayPresetRenderable`` for quick
preset-based output and ``FloatDisplayFormat`` when a call site needs explicit
control over decimal places, grouping, integer length, or sign display.

## Topics

### Building Output

- ``DisplayString``
- ``DisplayStringBuilder``
- ``DisplayBlock``
- ``DisplayFragment``
- ``DisplayFragmentRenderable``

### Blocks

- ``Labeled``
- ``Indented``
- ``IndentedLines``
- ``Divider``

### Numeric Formatting

- ``FloatDisplayFormat``
- ``FloatDisplayPreset``
- ``FloatFormattable``
- ``FloatComponentsLabeled``
- ``DisplayPresetRenderable``
- ``SignDisplay``
- ``AbbreviableLabel``
