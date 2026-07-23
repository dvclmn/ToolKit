# ``ColourTools``

Serialisable colour models, colour descriptors, luminance helpers, presets, and SwiftUI/AppKit bridge conveniences.

## Overview

ColourTools gives shared model code a way to talk about colour without needing to carry SwiftUI `Color`, AppKit `NSColor`, or other UI-framework types through core APIs.

The centre of the target is ``RGBColour``: a `Codable`, `Sendable`, hashable value type that stores concrete RGBA components as normalised `Double` values. It deliberately stores only component data, not palette labels, symbolic names, or framework colour roles. Use ``NamedColour`` when a colour needs a human-facing label or source, and use ``ColourDescriptor`` when stored data needs a broader colour vocabulary.

``HSVColour`` provides an editing-oriented representation for hue, saturation, brightness, and opacity, with conversion helpers between the two models.

Concrete colour models normalise their stored components when they are created. RGB components and alpha are clamped to `0...1`; HSV hue is wrapped to `[0, 1)`, while saturation, brightness, and alpha are clamped to `0...1`. Generated `id` values exist for `Identifiable` usage, but equality, hashing, and coding are based on colour components rather than per-instance identity or descriptive metadata.

``ColourDescriptor`` is the broader storage vocabulary. It can describe colours as RGB, HSV, raw component tuples, hex strings, system colours, or greys. System colours are symbolic framework colours: they resolve cleanly through SwiftUI/AppKit bridge properties, but they do not have an intrinsic ``RGBColour`` representation. The ``ColourDescriptor/rgbColour`` helper therefore returns `nil` for system colours rather than taking a lossy framework round trip.

The target also contains a small set of opinionated tools for luminance, contrast, and colour modification. Those APIs are useful, but more heuristic than the model types: treat them as interaction helpers rather than colour-science primitives.

## Topics

### Core Models

- ``RGBColour``
- ``HSVColour``
- ``ColourModel``
- ``ColourModelKind``
- ``RGBColourSpace``
- ``NamedColour``

### Serialisable Colour Descriptions

- ``ColourDescriptor``
- ``SystemColour``
- ``PrimitiveColour``
- ``ColourPair``

### Components and Editing

- <doc:HSVSemantics>
- ``ColourComponent``
- ``RGBComponent``
- ``HSVComponent``
- ``HSVAdjustment``
- ``HSVAdjustable``
- ``ColourModification``
- ``ModificationStrengthPreset``

### Luminance and Legibility

- ``LuminanceReadable``
- ``LuminanceMethod``
- ``LuminanceThreshold``
- ``ColourBrightness``
- ``ColourChroma``
- ``ColourPurpose``

### SwiftUI and AppKit Bridges

- ``SwiftUIColourConvertible``
- ``SwiftUIColourComponent``
- ``EnvironmentResolvableColour``
- ``LegibilityDarkenModifier``
