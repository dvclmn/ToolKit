//
//  LabelDisplay.swift
//
//
//  Created by Dave Coleman on 8/7/2024.
//

/// The preferred visible parts of a label.
public enum LabelDisplay: String, CaseIterable, Identifiable, Equatable, Sendable {
  public static let allCases: [LabelDisplay] = [ .iconOnly, .titleOnly, .titleAndIcon, .stacked ]
  
  case iconOnly
  case titleOnly
  case titleAndIcon
  case stacked
  
  @available(*, deprecated, message: "Use SwiftUI's `labelsVisibility(_:)` instead")
  case hidden

  public var id: String { rawValue }

  /// A display name suitable for controls and menus.
  public var name: String {
    switch self {
      case .iconOnly: "Icon only"
      case .titleOnly: "Title only"
      case .titleAndIcon: "Title & Icon"
      case .stacked: "Stacked"
      case .hidden: "Hidden"
    }
  }

  /// A Boolean value indicating whether title and icon should be stacked.
  public var isStacked: Bool {
    switch self {
      case .stacked: true
      default: false
    }
  }

}
