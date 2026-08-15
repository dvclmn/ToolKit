//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import SwiftUI

#if canImport(AppKit)
import AppKit
#endif

/// A representation of Modifiers that doesn't rely
/// on / can bridge between SwiftUI / AppKit
public struct Modifiers: OptionSet, Sendable, Hashable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let shift = Self(rawValue: 1 << 0)
  public static let option = Self(rawValue: 1 << 1)
  public static let command = Self(rawValue: 1 << 2)
  public static let control = Self(rawValue: 1 << 3)
  public static let capsLock = Self(rawValue: 1 << 4)
  public static let numericPad = Self(rawValue: 1 << 5)

  public static let all: Self = [
    .shift, .option, .command, .control, .capsLock, .numericPad,
  ]
}

extension Modifiers {
  public var isHoldingShift: Bool { contains(.shift) }
  public var isHoldingOption: Bool { contains(.option) }
  public var isHoldingCommand: Bool { contains(.command) }
  public var isHoldingControl: Bool { contains(.control) }
  public var isHoldingCapsLock: Bool { contains(.capsLock) }
  public var isHoldingNumericPad: Bool { contains(.numericPad) }
  
  public var isShiftOnly: Bool { self == [.shift] }
  public var isOptionOnly: Bool { self == [.option] }
  public var isCommandOnly: Bool { self == [.command] }
  public var isControlOnly: Bool { self == [.control] }
  public var isCapsLockOnly: Bool { self == [.capsLock] }
  public var isNumericPadOnly: Bool { self == [.numericPad] }
}

extension Optional where Wrapped == Modifiers {
  public var isHoldingShift: Bool { self?.contains(.shift) ?? false }
  public var isHoldingOption: Bool { self?.contains(.option) ?? false }
  public var isHoldingCommand: Bool { self?.contains(.command) ?? false }
  public var isHoldingControl: Bool { self?.contains(.control) ?? false }
  public var isHoldingCapsLock: Bool { self?.contains(.capsLock) ?? false }
  public var isHoldingNumericPad: Bool { self?.contains(.numericPad) ?? false }
  
  public var isShiftOnly: Bool { self == [.shift] }
  public var isOptionOnly: Bool { self == [.option] }
  public var isCommandOnly: Bool { self == [.command] }
  public var isControlOnly: Bool { self == [.control] }
  public var isCapsLockOnly: Bool { self == [.capsLock] }
  public var isNumericPadOnly: Bool { self == [.numericPad] }
}
