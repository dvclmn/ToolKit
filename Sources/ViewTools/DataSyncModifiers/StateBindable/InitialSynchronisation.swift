//
//  InitialSynchronisation.swift
//  ToolKit
//
//  Created by Dave Coleman on 12/8/2026.
//

/// Chooses how ``View/bindModel(debounce:_:to:initially:perform:)`` synchronises values when the view first appears.
public enum InitialBindingSynchronisation: Sendable {
  /// Copy the model value into the view-local value.
  case modelToView

  /// Copy the view-local value into the model value.
  case viewToModel

  /// Leave both values unchanged on first appearance.
  case none
}
