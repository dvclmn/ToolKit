//
//  QuickLabel.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/2/2025.
//

import CoreTools
import SwiftUI

public struct QuickLabel: View {
  @Environment(\.labelDisplay) private var labelDisplay

  let label: LabelDescriptor

  public init(_ label: LabelDescriptor) {
    self.label = label
  }

  public init(
    _ text: String,
    icon: IconLiteral? = nil,
  ) {
    let quickLabel = LabelDescriptor(text, icon: icon)
    self.label = quickLabel
  }

  public var body: some View {
    
    Label {
      Text(label.localisedTextResource)
//        .border(Color.orange.opacity(0.3))
    } icon: {
      if let icon = label.icon {
        IconView(icon)
//          .border(Color.purple.opacity(0.3))
      }
    }
  }
}

extension LabelDescriptor {
  public var localisedTextKey: LocalizedStringKey { .init(text) }
  
  public var localisedTextResource: LocalizedStringResource {
    .init(stringLiteral: text)
  }

}
