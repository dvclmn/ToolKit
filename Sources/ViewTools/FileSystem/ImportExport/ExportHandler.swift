//
//  ExportHandler.swift
//  ToolKit
//
//  Created by Dave Coleman on 7/6/2025.
//

import Foundation

/// Convenience entry points for writing exported data to disk.
public struct ExportHandler {

  /// Writes data to the user's Application Support directory.
  public static func saveDataToAppSupport(
    named fileName: String,
    data: Data,
  ) throws {
    // Get the Application Support directory.
    let directoryURL = FileManager.default.urls(
      for: .applicationSupportDirectory,
      in: .userDomainMask,
    ).first!

    // Create the directory if it does not exist.
    try FileManager.default.createDirectory(
      at: directoryURL,
      withIntermediateDirectories: true,
      attributes: nil,
    )

    // Append the filename.
    let fileURL = directoryURL.appendingPathComponent(fileName)

    // Write the data.
    try data.write(to: fileURL)
  }
}
