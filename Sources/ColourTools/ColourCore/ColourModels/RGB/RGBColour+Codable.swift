//
//  RGBColour+Codable.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/7/2026.
//

extension RGBColour {
  private enum CodingKeys: String, CodingKey {
    case red
    case green
    case blue
    case alpha
    case is255
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    try self.init(
      red: container.decode(Double.self, forKey: .red),
      green: container.decode(Double.self, forKey: .green),
      blue: container.decode(Double.self, forKey: .blue),
      alpha: container.decodeIfPresent(Double.self, forKey: .alpha) ?? 1.0,
      is255: container.decodeIfPresent(Bool.self, forKey: .is255) ?? false,
    )
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    let colour = normalised
    try container.encode(colour.red, forKey: .red)
    try container.encode(colour.green, forKey: .green)
    try container.encode(colour.blue, forKey: .blue)
    try container.encode(colour.alpha, forKey: .alpha)
    try container.encode(colour.is255, forKey: .is255)
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    let lhs = lhs.normalised
    let rhs = rhs.normalised
    return lhs.red == rhs.red
      && lhs.green == rhs.green
      && lhs.blue == rhs.blue
      && lhs.alpha == rhs.alpha
  }

  public func hash(into hasher: inout Hasher) {
    let colour = normalised
    hasher.combine(colour.red)
    hasher.combine(colour.green)
    hasher.combine(colour.blue)
    hasher.combine(colour.alpha)
  }
}
