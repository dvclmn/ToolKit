//
//  Direction+Exts.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/5/2026.
//

import CoreTools
import SwiftUI

extension Direction {
  
  public var toSwiftUIAxis: Axis {
    isVertical ? .vertical : .horizontal
  }

}
