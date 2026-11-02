//
//  Codable+Conformance.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

extension IdentifiedList: Decodable where Element: Decodable {
  /// Decodes an ordered array, rejecting duplicate IDs instead of losing data.
  public init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let decoded = try container.decode([Element].self)
    self.init()
    reserveCapacity(decoded.count)
    for (offset, element) in decoded.enumerated() {
      guard indexByID[element.id] == nil else {
        throw DecodingError.dataCorruptedError(
          in: container,
          debugDescription: "Duplicate element ID at offset \(offset)"
        )
      }
      append(element)
    }
  }
}

extension IdentifiedList: Encodable where Element: Encodable {
  public func encode(to encoder: any Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(elements)
  }
}
