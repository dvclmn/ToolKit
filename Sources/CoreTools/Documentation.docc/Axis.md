# Axis

Use CoreTools axis APIs to address two-dimensional values by logical direction
rather than by a specific stored property name.

## Overview

Two-dimensional types often store a pair of related scalar values:

- `CGSize` stores `width` and `height`.
- `CGPoint` stores `x` and `y`.
- `CGVector` stores `dx` and `dy`.
- Grid-like models often describe the same idea as `column` and `row`.

CoreTools separates those storage names from the logical axis you want to work
with. This keeps geometry code concise while making the current convention
explicit.

## Logical Axes

``GeometryAxis`` describes the direction in which values progress:

- ``GeometryAxis/horizontal`` is the x-axis direction. Columns advance
  horizontally, so column-oriented addressing uses the horizontal axis.
- ``GeometryAxis/vertical`` is the y-axis direction. Rows advance vertically, so
  row-oriented addressing uses the vertical axis.

This is a logical convention, not a description of the visual shape of a row or
column. A column may look vertical on screen, but its index changes as you move
left or right through the grid.

```text
   x ->  0   1   2
 y    +---+---+---+
 v    |   |   |   |   row 0
      +---+---+---+
      |   |   |   |   row 1
      +---+---+---+
      |   |   |   |   row 2
```

CoreTools defines ``GeometryAxis`` instead of relying on SwiftUI's `Axis` so
axis-oriented code can live in `CoreTools` without depending on SwiftUI. That
also gives the package a stable place for conventions such as ``GeometryAxis/row``
and ``GeometryAxis/column``.

## Stored Components

Most two-value geometry types have a primary and secondary storage slot. In the
default convention, primary storage maps to the horizontal axis and secondary
storage maps to the vertical axis:

| Type | Primary | Secondary |
| --- | --- | --- |
| `CGSize` | `width` | `height` |
| `CGPoint` | `x` | `y` |
| `CGVector` | `dx` | `dy` |

``AxisKeyPathReadable`` and ``AxisKeyPathWritable`` describe types that can read
or write those two slots through key paths. CoreTools provides conformances for
common Core Graphics types, which allows code to ask for "the value along
`.horizontal`" without manually switching over `width` versus `height`, or `x`
versus `y`.

```swift
let size = CGSize(width: 120, height: 80)

let width = size.value(along: .horizontal)
let height = size.value(along: .vertical)
let wider = size.setting(160, along: .horizontal)
```

## Axis Mapping

``AxisMapping`` resolves a logical axis to a stored component.

Use ``AxisMapping/identity`` for the normal convention:

- horizontal maps to primary storage.
- vertical maps to secondary storage.

Use ``AxisMapping/transposed`` when the relationship is flipped:

- horizontal maps to secondary storage.
- vertical maps to primary storage.

Passing an explicit mapping keeps rotated, transposed, or otherwise remapped
layouts from quietly assuming that `width` always means horizontal and `height`
always means vertical.

```swift
let size = CGSize(width: 120, height: 80)

let normalHorizontal = size.value(along: .horizontal)
let transposedHorizontal = size.value(along: .horizontal, mapping: .transposed)
```

## Axis Adjustments

The AxisAdjustment helpers build on readable and writable axis storage. They
let you adjust one or both axes without repeating the same switch logic at each
call site.

```swift
let point = CGPoint(x: 20, y: 40)

let shifted = point.adjust(.horizontal) { $0 + 10 }
let clamped = point.adjustBoth(with: CGPoint(x: 100, y: 100)) { value, limit in
  min(value, limit)
}
```

Use these helpers when the operation is naturally axis-oriented. Prefer direct
property access when the operation is specifically about a named stored property,
such as `size.width` or `point.y`.

## Topics

### Core Types

- ``GeometryAxis``
- ``AxisMapping``

### Axis-Addressable Storage

- ``AxisKeyPathReadable``
- ``AxisKeyPathWritable``
- ``AxisPair``

### Directional Values

- ``AxisOrientable``

