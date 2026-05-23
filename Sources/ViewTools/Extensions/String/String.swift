//
//  String.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI

extension String {

  public var toMarkdownCompatible: LocalizedStringKey {
    LocalizedStringKey(self)
  }
}
