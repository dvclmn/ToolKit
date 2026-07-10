//
//  GroupBoxStyle.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/6/2026.
//

import SwiftUI

public struct BaseGroupBoxStyle: GroupBoxStyle {

  let isProminent: Bool
  public func makeBody(configuration: Configuration) -> some View {

    VStack(alignment: .leading) {
      configuration.label
      configuration.content
        .quickBackground(tint: isProminent ? .accentColor : nil)
        .environment(\.colourIntensity, isProminent ? 0.2 : 0.1)
    }
  }
}

extension GroupBoxStyle where Self == BaseGroupBoxStyle {
  public static var base: Self { .init(isProminent: false) }
  public static var prominent: Self { .init(isProminent: true) }
}
