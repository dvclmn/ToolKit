//
//  QuickBackground+Style.swift
//  ToolKit
//
//  Created by Dave Coleman on 6/9/2026.
//

import SwiftUI

public enum QuickBackgroundStyle {
  case glass(GlassTypeCompatible?)
  case standard(tint: Color?)
}

extension QuickBackgroundStyle {
  var glassEffect: GlassTypeCompatible? {
    if case let .glass(glass) = self {
      return glass
    }
    return nil
  }
}
