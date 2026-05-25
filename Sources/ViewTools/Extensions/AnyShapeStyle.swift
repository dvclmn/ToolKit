//
//  AnyShapeStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

extension AnyShapeStyle {
  public init?(_ colour: Color?) {
    guard let colour else { return nil }
    self.init(colour)
  }
  public static var clear: Self { Self(Color.clear) }
}
