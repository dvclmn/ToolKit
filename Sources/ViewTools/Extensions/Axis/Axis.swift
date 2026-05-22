//
//  Axis.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//

import SwiftUI

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

}
