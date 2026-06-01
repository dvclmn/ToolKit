# ``CoreTools``

Small, composable foundation types and helpers used across ToolKit.

## Overview

CoreTools contains the non-SwiftUI layer of ToolKit: geometry helpers, colour
models, value stepping, labels, persistence keys, string utilities, and focused
extensions for Foundation and Core Graphics types.

The target is intended to stay independent from SwiftUI-specific concepts where
possible. When an idea also exists in SwiftUI, CoreTools uses its own lightweight
type when that keeps the API usable from non-view code.

## Topics

### Geometry

- <doc:Axis>
- ``GeometryAxis``
- ``AxisMapping``
- ``AxisKeyPathReadable``
- ``AxisKeyPathWritable``
- ``AxisOrientable``
- ``AxisPair``

### Value Stepping

- <doc:ValueStepping>
- ``StepDirection``

### Labels

- ``QuickLabel``
- ``LabeledItem``
- ``Pickable``
- ``NamedItem``
- ``IconItem``

### Persistence

- <doc:PersistenceKeys>
- ``PersistenceKey``
- ``PersistenceKeyRegistry``

### Toggling

- ``CaseTogglable``
- ``ToggleKind``
- ``ToggleKey``
- ``ToggleStrategy``

### Utilities

- <doc:StridableStepping>
