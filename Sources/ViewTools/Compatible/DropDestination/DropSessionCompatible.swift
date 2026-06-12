//
//  DropSessionCompatible.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI

public struct DropSessionCompatible: Identifiable {
  public let id: ID
  public let phase: Phase
  public let localSession: LocalSession?
  public let itemsCount: Int?
  public let suggestedOperations: DropOperationSetCompatible?
  public let size: CGSize?
  public let location: CGPoint
  
  public init(
    id: ID = .init(),
    phase: Phase,
    localSession: LocalSession? = nil,
    itemsCount: Int? = nil,
    suggestedOperations: DropOperationSetCompatible? = nil,
    size: CGSize? = nil,
    location: CGPoint,
  ) {
    self.id = id
    self.phase = phase
    self.localSession = localSession
    self.itemsCount = itemsCount
    self.suggestedOperations = suggestedOperations
    self.size = size
    self.location = location
  }
}

@available(iOS 26, macOS 26, *)
extension DropSessionCompatible {
  public init(_ session: DropSession) {
    self.init(
      id: ID(session.id),
      phase: Phase(session.phase),
      localSession: session.localSession.map(LocalSession.init),
      itemsCount: session.itemsCount,
      suggestedOperations: DropOperationSetCompatible(session.suggestedOperations),
      size: session.size,
      location: session.location,
    )
  }
}
