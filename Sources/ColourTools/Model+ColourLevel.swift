//
//  Model+ColourLevel.swift
//  Paperbark
//
//  Created by Dave Coleman on 29/6/2025.
//

import CoreTools

/// I don't at all understand the relationship between
/// `HierarchicalColour` and `ColourLevel`
public enum HierarchicalColour: String, Sendable, CaseCyclable, CaseIterable, NamedItem, Identifiable,
  Equatable
{

  public static let defaultCase: Self = .primary

  case primary  // Foreground by default
  case secondary  // Background by default

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }

  public func colour(for activeLevel: ColourLevel) -> Self {
    switch activeLevel {
      case .foreground: .primary
      case .background: .secondary
    }
  }

  static func slot(for level: ColourLevel, foregroundSlot: HierarchicalColour) -> HierarchicalColour {
    switch level {
      case .foreground: return foregroundSlot
      case .background: return foregroundSlot == .primary ? .secondary : .primary
    }

  }
}

public enum ColourLevel: String, Sendable, CaseCyclable, CaseIterable, NamedItem, Pickable, Identifiable {
  public typealias Item = Self
  public static let pickerLabel: QuickLabel = "Colour Level"

  public static let defaultCase: ColourLevel = .foreground

  case foreground
  case background

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }

  public var isForeground: Bool { self == .foreground }
  public var isBackground: Bool { self == .background }
}

extension ColourLevel: CustomStringConvertible {
  public var description: String { name }
}
