//
//  GeometryAxis+Set.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/8/2026.
//

import Foundation

extension GeometryAxis {
  public struct Set: OptionSet, Sendable, Hashable {
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    public let rawValue: Int
    
    public static let horizontal = Self(rawValue: 1 << 0)
    public static let vertical = Self(rawValue: 1 << 1)
    public static let all: Self = [.horizontal, .vertical]
  }
}

extension GeometryAxis.Set {
  public var displayName: String {
    let nameH = "Horizontal"
    let nameV = "Vertical"
    
    if self.isEmpty { return "None" }
    if self == .horizontal { return nameH }
    if self == .vertical { return nameV }
    if self == .all { return "\(nameH) & \(nameV)" }
    
    var parts: [String] = []
    if contains(.horizontal) { parts.append(nameH) }
    if contains(.vertical) { parts.append(nameV) }
    return parts.joined(separator: " & ")
  }
}
