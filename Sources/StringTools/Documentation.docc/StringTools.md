# ``StringTools``

String formatting, display-string composition, range conversion, and text-layout
helpers used across ToolKit.

## Overview

StringTools contains the text-focused layer of ToolKit. It includes safe string
and range conversion helpers, line splitting, pluralisation, Boolean and numeric
display formatting, attributed-string conveniences, and small builders for
debug-friendly display output.

The target is intentionally lightweight: formatting rules live in value types,
builder nodes are small and composable, and platform-specific helpers are kept
behind availability checks where needed.

## Topics

### Essentials

- <doc:StringFormatting>
- <doc:DisplayStrings>
- <doc:RangeDebugging>

### Lines and Components

- ``OmissionStrategy``
- ``SplitConfig``
- ``EmptyFieldPolicy``
- ``TrailingPolicy``

### Display Strings

- ``DisplayString``
- ``DisplayStringBuilder``
- ``DisplayBlock``
- ``DisplayFragment``
- ``DisplayFragmentRenderable``
- ``Labeled``
- ``Indented``
- ``IndentedLines``
- ``Divider``

### Floating-Point Display

- ``FloatDisplayFormat``
- ``FloatDisplayPreset``
- ``FloatFormattable``
- ``FloatComponentsLabeled``
- ``DisplayPresetRenderable``
- ``SignDisplay``
- ``AbbreviableLabel``

### Padding and Width

- ``TextPadAlignment``
- ``LinePadOptions``
- ``LineCaps``
- ``SurroundSpaces``
- ``OddPaddingPolicy``
- ``TextReflow``
- ``WidthCounter``
- ``ColumnString``

### Text Values

- ``BooleanDisplayFormat``
- ``CountStrategy``
- ``TextDecoration``
