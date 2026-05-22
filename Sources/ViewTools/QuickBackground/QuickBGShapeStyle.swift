//
//  QuickBGShapeStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

extension ShapeStyle where Self == TintedMaterial {
  public static var tintedMaterial: Self { .init() }
  public static func tintedMaterial(_ tint: Color) -> Self {
    .init(tint: tint)
  }
}

public struct TintedMaterial: ShapeStyle {
  let tint: Color
  
  public init(tint: Color = .primary) {
    self.tint = tint
  }
  public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
    FillShapeStyle()
  }
}
