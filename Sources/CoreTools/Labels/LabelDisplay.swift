//
//  LabelDisplay.swift
//
//
//  Created by Dave Coleman on 8/7/2024.
//

// TODO: See if `labelsVisibility(_:)` could be useful here, to express this better?
// https://developer.apple.com/documentation/swiftui/view/labelsvisibility(_:)
// https://developer.apple.com/documentation/swiftui/environmentvalues/labelsvisibility
/// The preferred visible parts of a label.
public enum LabelDisplay: String, CaseIterable, Identifiable, Equatable, Sendable {
  case iconOnly
  case titleOnly
  case titleAndIcon
  case stacked
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
  
  public var isVisible: Bool {
    switch self {
      case .hidden: false
      default: true
    }
  }
}
