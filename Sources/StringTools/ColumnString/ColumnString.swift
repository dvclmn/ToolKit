//
//  ColumnString.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/3/2026.
//

/// A string paired with a preferred column width.
public struct ColumnString: Sendable, Equatable, Hashable {
  /// The string content displayed in the column.
  public let content: String
  
  /// The width behaviour for the column.
  public let width: Width
  
  /// Creates a column string.
  public init(
    content: String,
    width: Width = .default
  ) {
    self.content = content
    self.width = width
  }
}

extension ColumnString: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(content: value)
  }
}

extension ColumnString {
  /// Width behaviour for a column string.
  public enum Width: Sendable, Equatable, Hashable {
    /// A fixed column width.
    case fixed(Int)
    
    /// A flexible width constrained by minimum and maximum values.
    case flexible(min: Int = 2, max: Int = Int.max)
    
    public static let `default`: Self = .fixed(3)
  }
}
