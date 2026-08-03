//
//  StringRenderable+Ext.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import StringTools
import CoreTools

extension Alignment: StringRenderable {
  public var stringValue: String { self.displayName.standard }
}

extension IconLiteral: StringRenderable {
  public var stringValue: String { stringRepresentation }
}
