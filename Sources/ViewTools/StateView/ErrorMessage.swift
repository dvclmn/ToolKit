//
//  ErrorMessage.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/6/2026.
//

import CoreTools

public struct ErrorMessage: Error {
  public let label: QuickLabel
  public let message: String

  public init(label: QuickLabel, message: String) {
    self.label = label
    self.label.text = message
  }
}

extension ErrorMessage {
  public init(_ title: String, error: Error) {
    self.init(label: .init(title), message: error.localizedDescription)
  }
}
