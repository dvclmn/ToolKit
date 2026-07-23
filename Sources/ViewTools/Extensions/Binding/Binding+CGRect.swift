//
//  Binding+CGRect.swift
//  ToolKit
//
//  Created by Dave Coleman on 24/1/2026.
//

import CoreTools
import SwiftUI

extension CGRect {
  /// The rectangle's origin, projected as `$rect.toBindingOrigin` when needed.
  public var toBindingOrigin: CGPoint {
    get { origin }
    set { origin = newValue }
  }

  /// The rectangle's size, projected as `$rect.toBindingSize` when needed.
  public var toBindingSize: CGSize {
    get { size }
    set { size = newValue }
  }
}

extension Optional where Wrapped == CGFloat {
  /// A zero-origin rectangle whose size is this value on `axis`.
  ///
  /// Use this through a binding subscript, for example
  /// `$length[rectAlong: .horizontal]`. The subscript is key-path projectable,
  /// unlike the previous `Binding(get:set:)` helper.
  public subscript(
    rectAlong axis: GeometryAxis,
    reversed isReversed: Bool = false,
  ) -> CGRect? {
    get {
      guard let value = self else { return nil }
      let valueAdjusted: CGFloat = isReversed ? -value : value
      let size: CGSize =
        switch axis {
          case .horizontal: CGSize(width: valueAdjusted, height: .zero)
          case .vertical: CGSize(width: .zero, height: valueAdjusted)
        }
      return CGRect(origin: .zero, size: size)
    }
    set {
      switch axis {
        case .horizontal:
          self = newValue?.size.width
        case .vertical:
          self = newValue?.size.height
      }
    }
  }
}
