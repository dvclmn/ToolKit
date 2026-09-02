//
//  CustomSymbolID.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/9/2026.
//

public struct CustomSymbolID: RawRepresentable, Sendable, Hashable, Codable, ExpressibleByStringLiteral {
  public let rawValue: String

  public init(rawValue: String) {
    self.rawValue = rawValue
  }

  public init(stringLiteral value: String) {
    self.init(rawValue: value)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.init(rawValue: try container.decode(String.self))
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
