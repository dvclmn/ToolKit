//
//  Compat+GlassEffect.swift
//  ToolKit
//
//  Created by Dave Coleman on 20/9/2025.
//

import SwiftUI

extension View {
  @ViewBuilder
  public func glassEffectCompatible<S: Shape>(
    _ glass: GlassTypeCompatible? = .regular,
    in shape: S,
  ) -> some View {
    if #available(anyAppleOS 26.0, *), let glass {
      glassEffect(glass.glassType, in: shape)
    } else {
      self
    }
  }
}

public enum GlassTypeCompatible: Sendable, Equatable {
  case regular(tint: Color? = nil)
  case clear
  case identity  // No glass effect at all
  case native(NativeGlass)
  public static let regular: Self = .regular()

  /// Wraps a SwiftUI glass effect with all of its configuration intact.
  @available(anyAppleOS 26.0, *)
  public init(glass: Glass) {
    self = .native(NativeGlass(glass))
  }

  @available(anyAppleOS 26.0, *)
  public var glassType: Glass {
    switch self {
      case .regular(let tint):
        guard let tint else { return .regular }
        return .regular.tint(tint)

      case .clear: return .clear
      case .identity: return .identity
      case .native(let nativeGlass): return nativeGlass.value
    }
  }

  public struct NativeGlass: Sendable, Equatable {
    // Erase the type so the enum can also be stored on earlier OS versions.
    private let storage: any Sendable

    @available(anyAppleOS 26.0, *)
    fileprivate init(_ glass: Glass) {
      self.storage = glass
    }

    @available(anyAppleOS 26.0, *)
    fileprivate var value: Glass {
      // The only initializer stores a Glass.
      storage as! Glass
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
      if #available(anyAppleOS 26.0, *) {
        return lhs.value == rhs.value
      }
      // NativeGlass can only be constructed on OS 26 or later.
      return false
    }
  }
}
