//
//  LabelDisplay+Ext.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension LabelDisplay {
  
  @MainActor
  public func toNative() -> (any LabelStyle)? {
    switch self {
      case .iconOnly: .iconOnly
      case .titleOnly: .titleOnly
      case .titleAndIcon, .stacked: .titleAndIcon
      case .hidden: nil
    }
  }

}
