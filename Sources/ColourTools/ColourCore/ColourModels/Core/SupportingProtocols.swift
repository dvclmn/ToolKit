//
//  SupportingProtocols.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

import Foundation

/// Shared identity fields for concrete colour models.
public protocol ColourModelIdentity: Identifiable where ID == UUID {
  var id: UUID { get }
//  var name: String? { get }
}

/// A colour model that carries opacity and can produce an opaque copy of itself.
public protocol ColourOpacityModel {
  var alpha: Double { get set }
  var toOpaque: Self { get }
  mutating func opacity(_ opacity: Double)
}

/// A colour model that can create neutral greyscale values.
public protocol GrayscaleColourModel {
  static func gray(_ brightness: Double, alpha: Double) -> Self
}
