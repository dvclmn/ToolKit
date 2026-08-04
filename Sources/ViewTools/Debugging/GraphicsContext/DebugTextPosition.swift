//
//  DebugCanvas.swift
//  ToolKit
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

public enum DebugTextPosition {
  case aboveOrigin
  case belowOrigin
  
  public var multiplierForYPosition: CGFloat {
    switch self {
      case .aboveOrigin: 1
      case .belowOrigin: -1
    }
  }
}
