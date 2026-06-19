# Debouncing

SwiftUI conveniences for CoreTools debouncing primitives.

ViewTools keeps the UI-specific pieces of debouncing close to SwiftUI: property
wrappers, view modifiers, and helpers for storing a debouncer in `State`.

The scheduling behaviour itself remains in CoreTools through `AsyncDebouncer`
and `DebounceMode`. That keeps debouncing available to non-view code while still
giving views small, declarative APIs for the common cases.
