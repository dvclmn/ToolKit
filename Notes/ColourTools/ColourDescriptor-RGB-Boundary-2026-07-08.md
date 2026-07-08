# ColourDescriptor RGB Boundary - 2026-07-08

## Summary

This pass tightened the separation between concrete colour components, symbolic colour descriptions, and human-facing colour names.

`RGBColour` is now treated as component data only: red, green, blue, alpha, generated list identity, and the `is255` provenance flag. It no longer stores a descriptive `name`. That keeps equality, hashing, coding, and conversion semantics focused on the actual RGBA value.

Human-facing labels should live outside the component model. `NamedColour` is the intended wrapper for palette entries, imported swatches, design tokens, or other labelled colour sources:

```swift
let swatch = NamedColour(
  name: "Console Prompt",
  source: "Xcode Dark",
  colour: .rgb(RGBColour.Xcode.consolePrompt)
)
```

## Descriptor Semantics

`ColourDescriptor` remains useful as the broader serialisable vocabulary. It can hold concrete RGB/HSV values, raw components, hex values, greys, and symbolic system colours.

The important distinction is that `ColourDescriptor.rgbColour` means "can this descriptor be flattened into concrete RGB components without resolving a framework colour?" It returns `nil` for `.system` because system colours are symbolic platform colours. They should resolve through the SwiftUI or AppKit bridge paths instead.

That avoids the misleading route:

```swift
ColourDescriptor.system(.primary) -> NSColor -> RGBColour -> Color
```

The framework route remains:

```swift
ColourDescriptor.system(.primary).colour
ColourDescriptor.system(.primary).nsColor
```

## API Changes

- `RGBColour.name` was removed.
- `RGBColour.from255` now accepts only RGB component integers.
- `RGBAConvertible` is now component-only: `init(r:g:b:a:)`.
- Hex initialisation now returns component values only. Wrap the result in `NamedColour` when the source label matters.
- Xcode RGB presets remain named by their static symbol names rather than storing duplicate labels inside each `RGBColour`.
- `ColourDescriptor.rgbColour` returns `nil` for `.system`.
- `SystemColour+RGB.swift` was removed because a direct `SystemColour.rgbColour` helper implied a stable concrete value where the source is really framework-resolved.

## Follow-Up Options

- Decide whether `HSVColour.name` should also move to `NamedColour` for symmetry. It is still present after this pass.
- Consider adding named palette collections that return `[NamedColour]` for Xcode presets or web colours, while keeping the existing `RGBColour` static constants as component-only conveniences.
- Consider documenting `ColourDescriptor.colour` and `ColourDescriptor.nsColor` as the canonical framework-resolution APIs for symbolic descriptors.
