# HSV Semantics

ColourTools uses two distinct HSV value types. Keeping their jobs separate
prevents a colour value from being accidentally applied as a change.

## Absolute colours

``HSVColour`` is an absolute colour: its hue, saturation, brightness, and alpha
describe the colour itself. It always stores a normalised value:

- Hue wraps into `[0, 1)`, where one turn is 360 degrees.
- Saturation, brightness, and alpha clamp to `0...1`.

Use an absolute HSV value when reading, storing, displaying, or replacing a
colour's components. ``HSVColour/replacing(hue:saturation:brightness:)`` treats
each supplied component as an absolute replacement, then normalises the result.

## Relative adjustments

``HSVAdjustment`` is a sparse, relative change. Its channels are optional so a
contributor can target only the axes it owns: `nil` means no contribution to an
axis, while `0` is an explicitly neutral contribution.

An adjustment is not itself normalised. Its hue is a delta in turns and can be
negative; saturation and brightness are deltas, conventionally in `-1...1`.
For example, `HSVAdjustment(hueDegrees: -18, saturation: 0.1)` means “rotate
hue backwards by 18 degrees and increase saturation by 0.1”.

``HSVColour/applying(_:)`` adds every specified delta to an absolute colour,
then produces a new normalised `HSVColour`. This is the sole point where an
adjustment's hue may wrap and its saturation or brightness may clamp.

## Combining and scaling

Adjustments compose arithmetically:

- `adding(other:)` sums each specified delta.
- `scaled(by:)` multiplies each specified delta.
- `interpolated(towards:amount:)` interpolates delta values linearly.

Hue adjustments deliberately use ordinary arithmetic here, rather than the
shortest path around the colour wheel. They are changes, not positions on that
wheel. The final absolute hue is wrapped only after the change is applied.

``ModificationStrengthPreset`` belongs to the higher-level contrast and
modification policy. It scales a collection of adjustments before their result
is applied; it is not stored inside an individual `HSVAdjustment`.

## Migration

The former `HSVAdjustment(fromAdjustable:)` operation was removed because it
mistakenly treated an absolute HSV colour as a relative adjustment. Use
`adjustable.toHSV` when the underlying absolute HSV colour is needed.

Likewise, `SystemColour.hsvColour` replaces the former `hsvAdjustment` property.
It resolves a symbolic platform colour to an absolute HSV snapshot.

`HSVAdjustment` no longer stores `strength`. To apply a multiplier to one
adjustment, use `adjustment.scaled(by: multiplier)` before combining or
applying it. Stored payloads from before this cleanup remain decodable; their
former `strength` key is ignored because it never affected direct application.
