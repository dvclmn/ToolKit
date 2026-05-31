//
//  QuickLabel+Role.swift
//  ToolKit
//
//  Created by Dave Coleman on 5/2/2026.
//

public enum ActionRole: Equatable, Sendable, Codable, Hashable {
  case success
  case destructive
  case error
  case warning
  case neutral

  // TODO: Find a different (more primitive) way to represent colour here,
  // or remove ActionRole, or move QuickLabel out of CoreTools.
//  public var colour: RGBColour? {
//    //  public var colour: Color? {
//    switch self {
//      case .success: .green
//      case .destructive: .red
//      case .error: .red
//      case .warning: .yellow
//      case .neutral: nil
//    }
//  }
}
