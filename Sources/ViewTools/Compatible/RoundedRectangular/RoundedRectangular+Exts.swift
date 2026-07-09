//
//  RoundedRectangular+Exts.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/7/2026.
//

import SwiftUI

extension Rectangle: RoundedRectangularShapeCompatible {
  nonisolated public func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible? {
    .fixed(0)
  }
}

extension RoundedRectangle: RoundedRectangularShapeCompatible {
  nonisolated public func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible? {
    .fixed(min(cornerSize.width, cornerSize.height))
  }
}

extension UnevenRoundedRectangle: RoundedRectangularShapeCompatible {
  nonisolated public func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible? {
    .init(
      topLeading: .fixed(cornerRadii.topLeading),
      topTrailing: .fixed(cornerRadii.topTrailing),
      bottomLeading: .fixed(cornerRadii.bottomLeading),
      bottomTrailing: .fixed(cornerRadii.bottomTrailing),
    )
  }
}

extension Capsule: RoundedRectangularShapeCompatible {
  nonisolated public func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible? {
    .fixed(size.map { min($0.width, $0.height) / 2 } ?? .infinity)
  }
}

extension Circle: RoundedRectangularShapeCompatible {
  nonisolated public func cornersCompatible(in size: CGSize?) -> RoundedRectangularShapeCornersCompatible? {
    .fixed(size.map { min($0.width, $0.height) / 2 } ?? .infinity)
  }
}
