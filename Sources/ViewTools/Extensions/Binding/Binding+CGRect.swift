//
//  Binding+CGRect.swift
//  ToolKit
//
//  Created by Dave Coleman on 24/1/2026.
//

import CoreTools
import SwiftUI

// MARK: - Binding CGRect
extension Binding where Value == CGRect {
  public var getOrigin: CGPoint {
    return self.wrappedValue.origin
  }
  public var getSize: CGSize {
    return self.wrappedValue.size
  }

  public var toBindingOrigin: Binding<CGPoint> {
    return Binding<CGPoint> {
      return self.wrappedValue.origin
    } set: { newValue in
      let currentSize: CGSize = self.wrappedValue.size
      self.wrappedValue = CGRect(origin: newValue, size: currentSize)
    }
  }

  public var toBindingSize: Binding<CGSize> {
    return Binding<CGSize> {
      wrappedValue.size
    } set: {
      let currentOrigin = wrappedValue.origin
      wrappedValue = CGRect(origin: currentOrigin, size: $0)
    }
  }
}

extension Binding where Value == CGFloat? {
  public func toBindingRect(
    along axis: GeometryAxis,
    reversed: Bool = false,
  ) -> Binding<CGRect?> {
    return Binding<CGRect?> {
      guard let value = wrappedValue else { return nil }
      let valueAdjusted: CGFloat = reversed ? -value : value
      let size: CGSize =
        switch axis {
          case .horizontal: CGSize(width: valueAdjusted, height: .zero)
          case .vertical: CGSize(width: .zero, height: valueAdjusted)
        }
      return CGRect(origin: .zero, size: size)
    } set: {
      switch axis {
        case .horizontal:
          wrappedValue = $0?.size.width
        case .vertical:
          wrappedValue = $0?.size.height
      }
      //
    }
  }
}
