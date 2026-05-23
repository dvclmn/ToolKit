//
//  CGSize+Conversion.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension CGSize {
  public func point(for unitPoint: UnitPoint) -> CGPoint {
    unitPoint.toCGPoint(in: self)
  }
}
