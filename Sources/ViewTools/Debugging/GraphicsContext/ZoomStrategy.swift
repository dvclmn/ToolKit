//
//  ZoomStrategy.swift
//  ToolKit
//
//  Created by Dave Coleman on 30/5/2026.
//

import SwiftUI

public enum ZoomStrategy {
  case environment
  case custom(CGFloat)
  case ignore
}

extension ZoomStrategy {
  func zoom(with environment: EnvironmentValues) -> CGFloat {
    switch self {
      case .environment: return environment.viewScale
      case .custom(let zoom): return zoom
      case .ignore: return 1
    }
  }
}
