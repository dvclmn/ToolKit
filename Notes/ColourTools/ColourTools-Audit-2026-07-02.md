# ColourTools Audit - 2026-07-02

## Current Shape

`ColourTools` is doing more than providing a serialisable RGB colour. The target currently breaks down into these subdomains:

- Core value models: `RGBColour`, `HSVColour`, `ColourModel`, `ColourComponent`, `RGBComponent`, `HSVComponent`, and `RGBColourSpace`.
- Serialisable colour vocabulary: `CodableColour`, `Colour`, `SystemColour`, `PrimitiveColour`, and `ColourPair`.
- Conversion and resolution: RGB/HSV conversion, hex parsing, `EnvironmentValues`-based SwiftUI colour resolution, `NSColor` conversion, and colour-space bridge helpers.
- Colour editing helpers: `HSVAdjustment`, `HSVAdjustable`, `ColourModification`, strength/purpose/chroma modifiers, and hue-preserving HSV interaction helpers.
- Luminance and legibility: WCAG/Rec.601/HSP/CIELAB luminance estimates, threshold-based contrast helpers, and `LegibilityDarkenModifier`.
- Presets: CSS/web-style RGB named colours, Xcode-theme colours, simple HSV named colours, and system-colour shortcuts.

The useful centre of gravity is clear: model code can store and pass colour values without depending on SwiftUI or AppKit, while UI code can resolve those values late. That is a good reason for the module to exist.

## What Looks Strong

- `RGBColour` is the right anchor type for lightweight serialisable colour. It is a value type, `Codable`, `Sendable`, and does not require UI framework types in its own file.
- The RGB/HSV split maps well to the two main needs: persisted concrete colour (`RGBColour`) and interactive editing (`HSVColour`).
- `CodableColour` is pragmatic. It gives call sites one enum that can represent concrete colours, system colours, raw values, hex strings, greys, and mixes.
- The component enums are a good design choice for UI controls. `RGBComponent` and `HSVComponent` make sliders, labels, and mutation code data-driven without inventing per-component types.
- Luminance support is more thoughtful than a single brightness check. Keeping WCAG, Rec.601, HSP, and CIELAB available is useful for experimenting with legibility heuristics.

## Critical Findings

1. `RGBColour.from255` was doing integer division before converting to `Double`, so values like `128` became `0.0`. This has been fixed and covered by `ColourToolsTests`.
2. The adjustment system has unclear units. `HSVAdjustment` documents hue as unit interval deltas, but `LuminanceThreshold.adjustment` uses `h: -18` and `h: -16`, which look like degrees. That can push hue far outside the expected range before conversion.
3. HSV adjustments do not clamp saturation/brightness or wrap hue. That may be intentional while experimenting, but the public API does not make the invariant clear enough yet.
4. `ColourCore` still imports AppKit for RGB/HSV conversion. For a macOS-first package this is acceptable, but it weakens the conceptual boundary implied by "core". A pure Swift conversion implementation would make the model layer easier to reuse and test.
5. `RGBColour` and `HSVColour` include generated `UUID` identity in their equality/hash/coding synthesis. That means two visually identical colours created separately are not equal. This may be correct for UI identity, but it is surprising for value-model colours and worth deciding explicitly.

## Cleanup Opportunities

- Decide whether colour equality should mean "same identity" or "same components". If identity is only for SwiftUI lists, consider separating persistent colour value from UI identity.
- Introduce a small normalisation policy: either clamp at initialisation, add `normalised`/`clamped` computed copies, or clearly document that callers must keep components in range.
- Replace the AppKit-backed HSV conversion with the commented pure Swift implementation once it is tested. That would make the core model layer match the module's stated reason for existing.
- Collapse duplicate hex parsing. `RGBAConvertible+Hex`, `HexColor`, `NSColor.fromHexString`, and `Color.init(hex:)` overlap and currently support slightly different formats and failure behaviour.
- Move or delete stale commented-out experimental blocks, especially `Model+Complementary.swift` and the old conversion implementations, after any useful context is captured in notes.
- Revisit `SystemColour` naming. `RGBColour.red` et al. are static approximations, while `SystemColour.red` is environment/platform-resolved. Keeping that distinction clear in docs will prevent misuse.
- Audit access control. Some convenience presets such as `CodableColour.olive` and `CodableColour.reddish` are internal while adjacent presets are public; that may be intentional, but it is not obvious.

## Suggested Next Steps

1. Add focused tests for RGB/HSV round-tripping, undefined hue preservation, hex parsing, and luminance thresholds.
2. Decide and document component invariants: normalised range, hue wrapping, alpha range, and whether 8-bit inputs are accepted only through `from255`.
3. Fix or rename the degree-like luminance hue adjustments. If they are degrees, convert them to unit values such as `-18.0 / 360.0`.
4. Extract a pure conversion layer so `ColourCore` is actually UI-framework independent, leaving `NSColor` and SwiftUI resolution files at the target edge.
5. Split public documentation into two DocC articles later: one for "Serialisable Colours" and one for "HSV Editing and Legibility". Keep the top-level DocC page as the map.
