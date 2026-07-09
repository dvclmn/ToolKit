//
//  Compat+RoundedRectangularShapeCorners.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

public enum RoundedRectangularCornerCompatible: Int8, CaseIterable, Sendable, Hashable {
  case topLeading
  case topTrailing
  case bottomLeading
  case bottomTrailing
}

public struct RoundedRectangularShapeCornersCompatible: Sendable, Hashable {
  public var topLeading: RoundedRectangularCornerStyleCompatible
  public var topTrailing: RoundedRectangularCornerStyleCompatible
  public var bottomLeading: RoundedRectangularCornerStyleCompatible
  public var bottomTrailing: RoundedRectangularCornerStyleCompatible
  
  public init(
    topLeading: RoundedRectangularCornerStyleCompatible = .fixed(0),
    topTrailing: RoundedRectangularCornerStyleCompatible = .fixed(0),
    bottomLeading: RoundedRectangularCornerStyleCompatible = .fixed(0),
    bottomTrailing: RoundedRectangularCornerStyleCompatible = .fixed(0),
  ) {
    self.topLeading = topLeading
    self.topTrailing = topTrailing
    self.bottomLeading = bottomLeading
    self.bottomTrailing = bottomTrailing
  }
  
  public init(all corner: RoundedRectangularCornerStyleCompatible) {
    self.init(
      topLeading: corner,
      topTrailing: corner,
      bottomLeading: corner,
      bottomTrailing: corner,
    )
  }
  
  public static func fixed(_ radius: CGFloat) -> Self {
    .init(all: .fixed(radius))
  }
  
  public static var concentric: Self {
    .concentric()
  }
  
  public static func concentric(
    minimum: RoundedRectangularCornerStyleCompatible? = nil
  ) -> Self {
    .init(all: .concentric(minimum: minimum))
  }
  
  public subscript(corner: RoundedRectangularCornerCompatible) -> RoundedRectangularCornerStyleCompatible {
    switch corner {
      case .topLeading:
        topLeading
      case .topTrailing:
        topTrailing
      case .bottomLeading:
        bottomLeading
      case .bottomTrailing:
        bottomTrailing
    }
  }
  
  func inset(by amount: CGFloat) -> Self {
    .init(
      topLeading: topLeading.inset(by: amount),
      topTrailing: topTrailing.inset(by: amount),
      bottomLeading: bottomLeading.inset(by: amount),
      bottomTrailing: bottomTrailing.inset(by: amount),
    )
  }
}
