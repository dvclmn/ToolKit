//
//  StringRenderable+Ext.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import StringTools

extension Alignment: StringRenderable {
  public var toString: String { self.displayName.standard }
}
