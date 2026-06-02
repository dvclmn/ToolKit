//
//  Collection+Checks.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/6/2026.
//

extension Collection where Element: Hashable {
  /// Returns `true` when `selection` contains exactly this collection's first element.
  public func isOnlyFirstSelected(
    in selection: Set<Element>
  ) -> Bool {
    guard let firstResultID = self.first else {
      return false
    }
    
    guard selection.count == 1,
          let firstSelected = selection.first
    else { return false }
    return firstResultID == firstSelected
  }
  
  public func isOnlyElementSelected(
    _ element: Element,
    in selection: Set<Element>,
  ) -> Bool {
    selection.count == 1 && selection.first == element
  }
}
