//
//  Binding+CGSize.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/6/2026.
//

import SwiftUI

extension CGSize {
  
  /// This ignores the rect's anchor, so leaves it at `zero`
  /// Just focuses on the rect's `size`
  public var toBindingRect: CGRect {
    get { CGRect(origin: .zero, size: self) }
    set { self = newValue.size }
  }
}

extension Optional where Wrapped == CGSize {
  
  /// This ignores the rect's anchor, so leaves it at `zero`
  /// Just focuses on the rect's `size`
  public var toBindingRect: CGRect? {
    get { map { CGRect(origin: .zero, size: $0) } }
    set { self = newValue?.size }
  }
}
