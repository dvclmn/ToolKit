//
//  ColourStyle.swift
//  VectorKit
//
//  Created by Dave Coleman on 8/7/2026.
//

// TODO: Can this produce a SwiftUI ShapeStyle?
public enum ColourStyle: Sendable, Hashable, Codable {

  case solid(ColourDescriptor)

  // TODO: Just linear for now, maybe support more later
  case gradient([ColourDescriptor])

  /// A solid colour produced by perceptually interpolating from `from` to `to`.
  /// A strength of `0` returns `from`; a strength of `1` returns `to`.
  case mix(
    from: ColourDescriptor,
    to: ColourDescriptor,
    amount: Double,
  )
}

