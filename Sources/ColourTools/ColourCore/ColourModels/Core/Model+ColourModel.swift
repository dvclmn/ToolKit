//
//  Model+Colours.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import Foundation
import CoreTools

public protocol ColourModelIdentity: Identifiable where ID == UUID {
  var id: UUID { get }
  var name: String? { get }
}

public protocol ColourOpacityModel {
  var alpha: Double { get set }
  var toOpaque: Self { get }
  mutating func opacity(_ opacity: Double)
}

public protocol GrayscaleColourModel {
  static func gray(_ brightness: Double, alpha: Double) -> Self
}

public protocol ColourModel: Codable, Equatable, ColourModelIdentity, ColourOpacityModel,
  GrayscaleColourModel
{}

extension ColourOpacityModel {
  public mutating func opacity(_ opacity: Double) { alpha = opacity }
}

public enum RGBColourSpace: String, Codable, Hashable, Sendable, CaseIterable, Identifiable {
  case sRGB
  case sRGBLinear
  case displayP3

  public var id: String { rawValue }
}

public protocol RGBColourSpaceRepresentable {
  var colourSpace: RGBColourSpace { get }
}

extension RGBColourSpaceRepresentable {
  public var colourSpace: RGBColourSpace { .sRGB }
}

public enum ColourModelKind: String, Hashable, Codable, Sendable, CaseIterable, CaseCyclable, Identifiable {
  public static let defaultCase: ColourModelKind = .rgb

  case rgb
  case hsv

  public var id: String { rawValue }
  public var name: String {
    switch self {
      case .rgb: "RGB"
      case .hsv: "HSV"
    }
  }

  public var icon: IconLiteral {
    switch self {
      case .rgb: .symbol("camera.filters")
      case .hsv: .symbol("cone")  // line.3.crossed.swirl.circle
    }
  }

  public var isRGB: Bool { self == .rgb }
  public var isHSV: Bool { self == .hsv }
}
