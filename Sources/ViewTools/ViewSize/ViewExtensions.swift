//
//  ViewExtensions.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/10/2025.
//

import CoreTools
import SwiftUI

// MARK: - View size modifiers
extension View {

  public func viewSize<T: GeometryCapturable>(
    capture: GeometryCapture<T>,
    mode debounceMode: DebounceMode,
    isEnabled: Bool = true,
    valueOutput: @escaping ViewSizeOutput<T>,
  ) -> some View {
    self.modifier(
      ViewSizeModifier(
        capture: capture,
        mode: debounceMode,
        isEnabled: isEnabled,
        valueOutput: valueOutput,
      )
    )
  }

  /// This updates environment value `viewportRect`
  /// `viewportRect` expresses both
  /// If a callback is needed, see ``viewSize(capture:mode:isEnabled:valueOutput:)``
  public func viewportCapture(mode debounceMode: DebounceMode) -> some View {
    self.modifier(
      EnvironmentViewportRectModifier(mode: debounceMode)
    )
  }
}
