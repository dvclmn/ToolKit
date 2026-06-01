//
//  ImportingHandler.swift
//  ToolKit
//
//  Created by Dave Coleman on 28/5/2025.
//

import Foundation

/// Convenience entry points for loading strings and decoding JSON resources.
public struct ImportHandler {

  /// Loads a string from a file URL.
  public static func loadString(
    from fileURL: URL,
    encoding: String.Encoding = .utf8
  ) throws -> String {
    do {
      return try String(contentsOf: fileURL, encoding: encoding)
    } catch {
      throw ImportError.failedToRead(error.localizedDescription)
    }
  }

  /// Loads a string resource from a bundle.
  public static func loadString(
    named fileName: String,
    withExtension fileExtension: String,
    in subdirectory: String? = nil,
    bundle: Bundle = .main
  ) throws -> String {
    guard
      let url = bundle.url(
        forResource: fileName,
        withExtension: fileExtension,
        subdirectory: subdirectory
      )
    else {
      throw ImportError.resourceNotFound(
        "\(fileName).\(fileExtension), in subdirectory \(String(describing: subdirectory))")
    }
    return try loadString(from: url)
  }

  /// Loads and decodes JSON data from a file URL.
  public static func loadData<T: Decodable>(
    from url: URL,
    asType type: T.Type,
  ) throws -> T {
    let data = try Data(contentsOf: url)
    do {
      let decoder = JSONDecoder()
      print("Attempting to decode Data from URL \(url)")
      return try decoder.decode(type, from: data)
    } catch {
      print("Failed to decode Data from URL \(url) with error \(error)")
      throw ImportError.decodingFailed(error)
    }
  }

  /// Loads and decodes a JSON resource from a bundle.
  public static func loadDataFromBundle<T: Decodable>(
    named name: String,
    withExtension ext: String,
    asType type: T.Type,
    bundle: Bundle = .main,
  ) throws -> T {
    guard let url = bundle.url(forResource: name, withExtension: ext) else {
      print("Resource named \(name).\(ext) not found in bundle \(bundle)")
      throw ImportError.resourceNotFound("\(name).\(ext)")
    }
    return try loadData(from: url, asType: type)
  }
}

extension ImportHandler {
  /// Loads and decodes JSON from a security-scoped file-import result.
  public static func loadSecurityScoped<T: Decodable>(
    result: Result<URL, Error>,
    asType type: T.Type,
  ) throws -> T {

    switch result {
      case .success(let url):

        defer { url.stopAccessingSecurityScopedResource() }

        // Start accessing the security-scoped resource before reading the file.
        guard url.startAccessingSecurityScopedResource() else {
          throw ImportError.failedSecurityScopedAccess(url.lastPathComponent)
        }

        return try loadData(from: url, asType: type)

      case .failure(let error):
        throw ImportError.fileImporterFailure(error)
    }
  }
}
