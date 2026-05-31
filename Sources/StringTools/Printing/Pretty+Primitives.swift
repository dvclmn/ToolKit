//
//  Pretty+Primitives.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

// MARK: - Basic Types

extension String: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\"\(self)\""
  }
}
extension Character: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\"\(self)\""
  }
}

extension Int: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}

extension Double: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}

extension Bool: PrettyPrintable {
  package func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    "\(config.typeName(self))\(self)"
  }
}
