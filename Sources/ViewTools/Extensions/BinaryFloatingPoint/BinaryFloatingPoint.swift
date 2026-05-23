//
//  BinaryFloatingPoint.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension BinaryFloatingPoint {

  public var toAngle: Angle { .degrees(Double(self)) }
}
