//
//  Binding+CGSize.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/6/2026.
//

import SwiftUI

extension Binding where Value == CGSize {
  
  /// This ignores the rect's anchor, so leaves it at `zero`
  /// Just focuses on the rect's `size`
  public var toBindingRect: Binding<CGRect> {
    return Binding<CGRect> {
      wrappedValue.toCGRectZeroOrigin
    } set: {
      wrappedValue = $0.size
    }
  }
}

extension Binding where Value == CGSize? {
  
  /// This ignores the rect's anchor, so leaves it at `zero`
  /// Just focuses on the rect's `size`
  public var toBindingRect: Binding<CGRect?> {
    return Binding<CGRect?> {
      wrappedValue?.toCGRectZeroOrigin
    } set: {
      wrappedValue = $0?.size
    }
  }
}
