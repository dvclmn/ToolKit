//
//  ErrorMessage.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/6/2026.
//

import CoreTools

public struct ErrorMessage: Error {

  public let title: String
  public let icon: IconLiteral?
  public let message: String

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String,
  ) {
    self.title = title
    self.icon = icon
    self.message = message
  }

}

extension ErrorMessage {
  public init(
    label: LabelDescriptor,
    message: String,
  ) {
    self.init(label.text, icon: label.icon, message: message)
  }
  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    error: Error,
  ) {
    self.init(title, icon: icon, message: error.localizedDescription)
  }
  
  public var label: LabelDescriptor { .init(title, icon: icon) }
}
