//
//  CreateDebouncer.swift
//  ToolKit
//
//  Created by Dave Coleman on 24/5/2026.
//

import CoreTools
import SwiftUI

extension DebounceMode {
  public func createDebouncer() -> State<AsyncDebouncer?> {
    switch self {
      case .noDebounce: State(initialValue: nil)
      case .debounce(let interval): State(initialValue: AsyncDebouncer(interval: interval))
    }
  }
}
