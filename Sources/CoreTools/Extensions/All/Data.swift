//
//  Encodable.swift
//  Collection
//
//  Created by Dave Coleman on 19/1/2025.
//

import Foundation

extension Data {
  @_spi(Internal) public func prettyPrinted(
    writingOptions: JSONSerialization.WritingOptions = [.prettyPrinted]
  ) -> String {
    guard
      let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let prettyData = try? JSONSerialization.data(withJSONObject: object, options: writingOptions),
      let prettyString = String(data: prettyData, encoding: .utf8)
    else { return String(data: self, encoding: .utf8) ?? "nil" }
    return prettyString
  }

  @_spi(Internal) public var prettyPrinted: String {
    prettyPrinted()
  }
}

extension String {
  @_spi(Internal) public func prettyPrintedJSON(
    writingOptions: JSONSerialization.WritingOptions = [.prettyPrinted]
  ) -> String {
    guard let data = data(using: .utf8) else {
      return self
    }

    return data.prettyPrinted(writingOptions: writingOptions)
  }
}

extension Encodable {
  @_spi(Internal) public func prettyPrintedJSON(
    outputFormatting: JSONEncoder.OutputFormatting = [.prettyPrinted, .sortedKeys]
  ) -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = outputFormatting

    guard let data = try? encoder.encode(self) else {
      return String(describing: self)
    }

    return data.prettyPrinted(writingOptions: outputFormatting.jsonSerializationWritingOptions)
  }
}

extension JSONEncoder.OutputFormatting {
  fileprivate var jsonSerializationWritingOptions: JSONSerialization.WritingOptions {
    var options: JSONSerialization.WritingOptions = []

    if contains(.prettyPrinted) {
      options.insert(.prettyPrinted)
    }

    if contains(.sortedKeys) {
      options.insert(.sortedKeys)
    }

    return options
  }
}
