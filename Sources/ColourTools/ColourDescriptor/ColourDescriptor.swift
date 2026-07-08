//
//  ColourDescriptor.swift
//  Colour Library
//
//  Created by Dave Coleman on 3/9/2025.
//

/// A serialisable colour description that can hold concrete model colours,
/// raw components, system colours, greys, hex strings, and simple mixes.
///
/// Use this when stored data or lightweight core models need to refer to a
/// colour without depending on SwiftUI `Color` or AppKit `NSColor`.
/// UI-specific files in this target resolve `ColourDescriptor` into framework colours at the edge.
///
/// Renderers can often take HSV values directly, but resolved concrete output
/// usually gives RGB. System colours remain symbolic until a SwiftUI or AppKit
/// bridge resolves them.

// Credit to Natalia Panferova and Matthaus Woolard of
// https://nilcoalescing.com/blog/EncodeAndDecodeSwiftUIColor/

public enum ColourDescriptor: Codable, Equatable, Hashable, Sendable, Identifiable {
  
  /// Supports up to 8-digit hex values. See ``RGBAConvertible``.
  case hex(String)
  case rgb(RGBColour)
  case rgbRaw(r: Double, g: Double, b: Double, a: Double = 1)
  case hsv(HSVColour)
  case hsvRaw(h: Double, s: Double, v: Double, a: Double = 1)

  /// A platform semantic colour resolved by SwiftUI or AppKit bridge code.
  ///
  /// This case is intentionally not flattened by ``rgbColour`` because system
  /// colours can be dynamic and environment-dependent.
  case system(SystemColour, opacity: Double = 1)

  case grey(Double, opacity: Double = 1)  // 0 == black, 1 == white

}

extension ColourDescriptor {
  @available(*, deprecated, renamed: "hex(_:)")
  public static func hex(_ string: String, opacity: Double = 1) -> Self {
    .hex(string)
  }
}

extension ColourDescriptor {
  public var id: Self { self }

  public init?(fromPrimitive primitiveColour: PrimitiveColour) {
    guard let colour = primitiveColour.toSystemColour else { return nil }
    self = ColourDescriptor.system(colour, opacity: 1.0)
  }
  public var name: String {
    switch self {
      case .hex(let string):
        "Hex: \(string)"

      case .rgb(let rGBColour):
        "RGBColour: \(rGBColour.description)"

      case .rgbRaw(let r, let g, let b, let a):
        "RGB (components): \(r), \(g), \(b), Opacity: \(a)"

      case .hsv(let hSVColour):
        "HSVColour: \(hSVColour.description)"

      case .hsvRaw(let h, let s, let v, let a):
        "HSV (components): \(h), \(s), \(v), Opacity: \(a)"

      case .system(let systemColour, let opacity):
        "System Colour: \(systemColour.name), Opacity: \(opacity)"

      case .grey(let double, let opacity):
        "Grey: \(double), Opacity: \(opacity)"

//      case .mix(let primary, let secondary, let strength, let opacity):
//        "Mix: \(primary.description) + \(secondary.description), Amount: \(strength), Opacity: \(opacity)"
    }
  }
  
  public init(_ rgbColour: RGBColour) {
    self = .rgb(rgbColour)
  }
}
