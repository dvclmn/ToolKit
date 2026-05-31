//
//  Date.swift
//  Collection
//
//  Created by Dave Coleman on 22/1/2025.
//

import Foundation

extension Date {

  @_spi(Internal) public static var debug: String {
    Date.now.formatted(
      .dateTime
        .hour().minute().second()
        .secondFraction(.fractional(3))
    )
  }

  package func dayOfTheMonthIcon(day: Int? = nil) -> String {
    let today: Int = day ?? Calendar.current.component(.day, from: self)
    return "\(today).calendar"
  }

  // MARK: - (x) Ago

  package func secondsAgo(_ seconds: TimeInterval) -> Date {
    return Date().addingTimeInterval(-seconds)
  }

  package func minutesAgo(_ minutes: TimeInterval) -> Date {
    return Date().addingTimeInterval(-minutes * 60)
  }

  package func hoursAgo(_ hours: TimeInterval) -> Date {
    return Date().addingTimeInterval(-hours * 3600)
  }

  package func daysAgo(_ days: TimeInterval) -> Date {
    return Date().addingTimeInterval(-days * 86400)
  }

  // MARK: - (x) From Now

  /// Returns a date `seconds` seconds from now.
  package func secondsFromNow(_ seconds: TimeInterval) -> Date {
    return Date().addingTimeInterval(seconds)
  }

  /// Returns a date `minutes` minutes from now.
  package func minutesFromNow(_ minutes: TimeInterval) -> Date {
    return Date().addingTimeInterval(minutes * 60)
  }

  /// Returns a date `hours` hours from now.
  package func hoursFromNow(_ hours: TimeInterval) -> Date {
    return Date().addingTimeInterval(hours * 3600)
  }

  /// Returns a date `days` days from now.
  package func daysFromNow(_ days: TimeInterval) -> Date {
    return Date().addingTimeInterval(days * 86400)
  }
}
