//
//  GeometryAxis.swift
//  ToolKit
//
//  Created by Dave Coleman on 3/7/2025.
//

import Foundation

/// A logical axis for addressing two-dimensional geometry.
///
/// Use ``horizontal`` for x-axis or column progression, and ``vertical`` for
/// y-axis or row progression. The axis describes the direction in which values
/// change, not the visual shape of the row or column being addressed.
///
/// For the broader convention used by CoreTools, see <doc:Axis>.
public enum GeometryAxis: String, Sendable, Codable, Equatable, Hashable, CaseIterable, Identifiable {
  case horizontal  // Column
  case vertical  // Row

  public static var column: Self { .horizontal }
  public static var row: Self { .vertical }

}

extension GeometryAxis {
  public var id: String { rawValue }

  public var displayName: String {
    switch self {
      case .horizontal: "Horizontal"
      case .vertical: "Vertical"
    }
  }

  public var icon: String {
    switch self {
      case .horizontal: "arrow.left.and.right.text.vertical"
      case .vertical: "arrow.up.and.down.text.horizontal"
    }
  }

  public var label: LabelDescriptor { .init(displayName, symbol: icon) }

  public var toSet: GeometryAxis.Set {
    switch self {
      case .horizontal: [.horizontal]
      case .vertical: [.vertical]
    }
  }

  public var isHorizontal: Bool { self == .horizontal }
  public var isVertical: Bool { self == .vertical }

  public var opposing: Self {
    switch self {
      case .horizontal: .vertical
      case .vertical: .horizontal
    }
  }

  public func axisOffset(
    frameInViewport frame: CGRect
  ) -> CGSize {
    return switch self {
      case .horizontal:
        CGSize(
          width: frame.origin.x,
          height: 0,
        )
      case .vertical:
        CGSize(
          width: 0,
          height: frame.origin.y,
        )

    }
  }

  public func hasOverflow(
    contentFrame: CGRect,
    buffer: CGFloat,
  ) -> Bool {
    switch self {
      case .horizontal:
        let minX = contentFrame.minX - buffer
        let hasOverflow: Bool = minX < 0
        return hasOverflow

      case .vertical:
        let minY = contentFrame.minY - buffer
        let hasOverflow: Bool = minY < 0
        return hasOverflow
    }
  }
}
