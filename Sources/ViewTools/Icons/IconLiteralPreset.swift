//
//  IconLiteralPreset.swift
//  ToolKit
//
//  Created by Dave Coleman on 1/6/2026.
//

import CoreTools

extension IconLiteral {
  public static func preset(_ iconPreset: Icons) -> Self {
    self.init(stringLiteral: iconPreset.icon)
  }
  
  public static var randomSymbol: Self {
    .symbol(Icons.getRandom.icon)
  }
}
