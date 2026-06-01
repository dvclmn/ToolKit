# Persistence Keys

Declare persisted values as small key types so the storage string, value type,
and default value stay together.

## Overview

``PersistenceKey`` is useful when the same persisted value is read from multiple
places. The concrete key type becomes the shared source of truth for the storage
key and default value.

```swift
struct ShaderEnabledKey: PersistenceKey {
  static let storageKey = "drawString.shaders.enabled"
  static let defaultValue = true
}
```

When the value is a boolean toggle, conform to ``ToggleKey`` to get the default
`Bool` value and derived display name behaviour.

```swift
struct InspectorExpandedKey: ToggleKey {
  static let kind: ToggleKind = .expanded
  static let storageKey = key(from: "drawString", "inspector")
}

let title = InspectorExpandedKey.displayName
```

Register keys during development to catch duplicate storage strings early:

```swift
@MainActor
func registerPersistenceKeys() {
  PersistenceKeyRegistry.register(ShaderEnabledKey.self)
  PersistenceKeyRegistry.register(InspectorExpandedKey.self)
}
```

## Topics

### Key Types

- ``PersistenceKey``
- ``ToggleKey``
- ``ToggleKind``
- ``PersistenceKeyRegistry``
