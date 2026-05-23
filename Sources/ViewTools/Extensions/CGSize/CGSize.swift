//
//  CGSize.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension CGSize {
  
  /// Returns a new size reduced by the specified edge insets,
  /// and clamped to a minimum value of `0` for each dimension.
  /// - Parameter insets: The per-edge insets to apply. Width is reduced by `left + right`, height by `top + bottom`.
  /// - Returns: A new CGSize with the insets applied
  public func inset(by insets: EdgeInsets) -> CGSize {
    let newWidth = max(0, width - (insets.leading + insets.trailing))
    let newHeight = max(0, height - (insets.top + insets.bottom))
    return CGSize(width: newWidth, height: newHeight)
  }

}
