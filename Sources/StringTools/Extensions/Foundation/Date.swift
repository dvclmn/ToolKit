//
//  Date.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/5/2026.
//

import Foundation

extension Date {
  /// Returns the SF Symbol name for a calendar icon representing the day of the
  /// month.
  public func dayOfTheMonthIcon(day: Int? = nil) -> String {
    let today: Int = day ?? Calendar.current.component(.day, from: self)
    return "\(today).calendar"
  }
}
