//
//  LabelPart.swift
//  ViewKit
//
//  Created by Dave Coleman on 7/2/2026.
//

import CoreTools
import SwiftUI

public enum LabelPart {
  case title
  case icon
}

extension LabelPart {

  public var isIcon: Bool {
    if case .icon = self {
      return true
    }
    return false
  }

  public var isTitle: Bool {
    if case .title = self {
      return true
    }
    return false
  }

  public func weight(
    override: Font.Weight? = nil  // Usually from environment
  ) -> Font.Weight? {
    override ?? weight
  }

  private var weight: Font.Weight {
    switch self {
      case .title: .regular
      case .icon: .semibold
    }
  }
}
