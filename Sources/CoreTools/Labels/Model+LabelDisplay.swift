//
//  File.swift
//
//
//  Created by Dave Coleman on 8/7/2024.
//

// import SwiftUI

public enum LabelDisplay: String, CaseIterable, Identifiable, Equatable, Sendable {

  case iconOnly
  case titleOnly
  case titleAndIcon
  case stacked
  case hidden

  public var id: String { rawValue }

  public var name: String {
    switch self {
      case .iconOnly: "Icon only"
      case .titleOnly: "Title only"
      case .titleAndIcon: "Title & Icon"
      case .stacked: "Stacked"
      case .hidden: "Hidden"
    }
  }

  public var isStacked: Bool {
    switch self {
      case .stacked: true
      default: false
    }
  }
}
