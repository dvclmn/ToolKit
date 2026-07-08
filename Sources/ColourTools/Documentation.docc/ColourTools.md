# ``ColourTools``

Serialisable colour models, colour-space conversions, luminance helpers, presets, and SwiftUI/AppKit bridge conveniences.

## Overview

ColourTools gives shared model code a way to talk about colour without needing to carry SwiftUI `Color`, AppKit `NSColor`, or other UI-framework types through core APIs.

The centre of the target is ``RGBColour``: a `Codable`, `Sendable`, hashable value type that stores concrete RGBA components as normalised `Double` values. ``HSVColour`` provides an editing-oriented representation for hue, saturation, brightness, and opacity, with conversion helpers between the two models.

Concrete colour models normalise their stored components when they are created. RGB components and alpha are clamped to `0...1`; HSV hue is wrapped to `[0, 1)`, while saturation, brightness, and alpha are clamped to `0...1`. Generated `id` values exist for `Identifiable` usage, but equality, hashing, and coding are based on colour components rather than per-instance identity.

``ColourDescriptor`` is the broader storage vocabulary. It can describe colours as RGB, HSV, raw component tuples, hex strings, system colours, greys, or simple mixes. The framework-specific extension files resolve those descriptions into SwiftUI and AppKit colours at the UI boundary.

The target also contains a small set of opinionated tools for luminance, contrast, and colour modification. Those APIs are useful, but more heuristic than the model types: treat them as interaction helpers rather than colour-science primitives.

## Topics

### Core Models

- ``RGBColour``
- ``HSVColour``
- ``ColourModel``
- ``ColourModelKind``
- ``RGBColourSpace``

### Serialisable Colour Descriptions

- ``ColourDescriptor``
- ``Colour``
- ``SystemColour``
- ``PrimitiveColour``
- ``ColourPair``

### Components and Editing

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
