//
//  LocationInfo.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/7/2026.
//

import Foundation

public struct LocationInfo: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let userDefaults = Self(rawValue: 1 << 0)
  public static let applicationSupport = Self(rawValue: 1 << 1)
  public static let all: Self = [.userDefaults, .applicationSupport]
}

extension LocationInfo {
  var locationInfo: String {
    guard !isEmpty else { return "No location selected" }

    var parts: [String] = []

    if contains(.userDefaults),
       let path = userDefaultsPath {
      parts.append("UserDefaults file path: \(path)")
    }

    if contains(.applicationSupport),
       let path = applicationSupportPath {
      parts.append("Application Support file path: \(path)")
    }

    return parts.joined(separator: "\n")
  }

  private var userDefaultsPath: String? {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
      return nil
    }

    return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
      .first?
      .appendingPathComponent("Preferences")
      .appendingPathComponent("\(bundleIdentifier).plist")
      .path
  }

  private var applicationSupportPath: String? {
    FileManager.default.urls(
      for: .applicationSupportDirectory,
      in: .userDomainMask,
    ).first?.path
  }
}
