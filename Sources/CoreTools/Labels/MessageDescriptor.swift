//
//  MessageDescriptor.swift
//  ToolKit
//
//  Created by Dave Coleman on 18/8/2026.
//

public struct MessageDescriptor {
  let title: String
  let icon: IconLiteral?
  public let message: String

  public init(
    _ title: String,
    icon: IconLiteral?,
    message: String,
  ) {
    self.title = title
    self.icon = icon
    self.message = message
  }
}

extension MessageDescriptor {
  public var label: LabelDescriptor { .init(title, icon: icon) }
}
