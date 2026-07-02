//
//  ColourComponentNormalisation.swift
//  ToolKit
//

import CoreTools
import Foundation

enum ColourComponentNormalisation {
  static func clampUnit(_ value: Double) -> Double {
    guard value.isFinite else { return 0 }
    return value.clamped(to: .unitRange)
  }

  static func wrapHue(_ value: Double) -> Double {
    guard value.isFinite else { return 0 }
    return value.wrappedUnit()
  }

  static func normalise8Bit(_ value: Int) -> Double {
    Double(value.clamped(0, 255)) / 255.0
  }
}
