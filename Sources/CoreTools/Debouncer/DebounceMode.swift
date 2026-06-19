//
//  ShouldDebounce.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/7/2025.
//

import Foundation

/// Whether repeated work should run immediately or after a debounce interval.
///
/// `DebounceMode` lives in `CoreTools` because it describes scheduling policy,
/// not view lifecycle. `ViewTools` layers SwiftUI-specific storage and modifier
/// conveniences on top of this value.
public enum DebounceMode {
  case noDebounce
  case debounce(TimeInterval = 0.2)
}
