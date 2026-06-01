//
//  ShouldDebounce.swift
//  ToolKit
//
//  Created by Dave Coleman on 15/7/2025.
//

import Foundation

/// Whether an operation should run immediately or after a debounce interval.
public enum DebounceMode {
  case noDebounce
  case debounce(TimeInterval = 0.2)
}
