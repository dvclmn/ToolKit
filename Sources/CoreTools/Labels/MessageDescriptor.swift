//
//  MessageDescriptor.swift
//  ToolKit
//
//  Created by Dave Coleman on 18/8/2026.
//

public struct MessageDescriptor {
  let title: String
  let icon: IconLiteral?
  let message: String

  init(
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
  var label: LabelDescriptor { .init(title, icon: icon) }
}
