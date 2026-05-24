//
//  ShouldDebounce.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/7/2025.
//

// import SwiftUI
import Foundation

public enum DebounceMode {
  case noDebounce
  case debounce(TimeInterval = 0.2)
}
