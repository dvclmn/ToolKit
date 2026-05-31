//
//  Date.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/5/2026.
//

import Foundation

extension Date {
  public func dayOfTheMonthIcon(day: Int? = nil) -> String {
    let today: Int = day ?? Calendar.current.component(.day, from: self)
    return "\(today).calendar"
  }
}
