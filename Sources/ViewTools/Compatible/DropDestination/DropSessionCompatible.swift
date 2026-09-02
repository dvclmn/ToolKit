//
//  DropSessionCompatible.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/6/2026.
//

import SwiftUI
import StringTools

public struct DropSessionCompatible: Identifiable {
  public let id: ID
  public let phase: Phase
  
  /// Provides additional information about a session
  /// if it originated within the app.
  ///
  /// This property is set to `nil` if drag originated outside the app.
  public let localSession: LocalSession?
  public let itemsCount: Int?
  
  /// Operations suggested by the drag source.
  public let suggestedOperations: DropOperationSetCompatible?
  
  /// Size of the drop destination view.
  public let size: CGSize?
  
  /// Location of drop in the local coordinate space
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

extension DropSessionCompatible {
  public var isLocalSession: Bool { localSession != nil }
}
extension DropSessionCompatible: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Labeled("Phase", value: phase.displayName)
      Labeled("Is Local Session?", value: isLocalSession)
      Labeled("Item count", value: itemsCount?.description)
      Labeled("Suggested Operations", value: suggestedOperations?.displayName)
      Labeled("Size", value: size)
      Labeled("Location", value: location)
    }
    .text
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
