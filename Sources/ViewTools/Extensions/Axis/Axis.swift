//
//  Axis.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//

import SwiftUI
import CoreTools

extension Axis {
  public var toAxisSet: Axis.Set {
    switch self {
      case .horizontal: [.horizontal]
      case .vertical: [.vertical]
    }
  }
  public var toEdgeSet: Edge.Set {
    switch self {
      case .horizontal: .horizontal
      case .vertical: .vertical
    }
  }

  public var isHorizontal: Bool {
    self == .horizontal
  }

  public var isVertical: Bool {
    self == .vertical
  }
  
  public var toGeometryAxis: GeometryAxis {
    switch self {
      case .horizontal: .horizontal
      case .vertical: .vertical
    }
  }

}

extension AxisMapping {

  /// Converts a physical axis (SwiftUI.Axis) into logical GeometryAxis.
  public func map(_ swiftUIAxis: Axis) -> GeometryAxis {
    let axis = swiftUIAxis.toGeometryAxis
    return map(axis)
  }
}

extension GeometryAxis {
  
  public var cellNumberTextAlignment: UnitPoint {
    switch self {
      case .horizontal: .center
      case .vertical: .trailing
    }
  }
  
  public var numberingShapeAlignment: Alignment {
    switch self {
      case .horizontal: .top
      case .vertical: .leading
    }
  }

  public var toSwiftUIAxis: Axis {
    switch self {
      case .horizontal: .horizontal
      case .vertical: .vertical
    }
  }
}
