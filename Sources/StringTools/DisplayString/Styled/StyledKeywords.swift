//
//  Model+Styled.swift
//  ToolKit
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

/// Keywords that can be highlighted in display strings.
public struct StyledKeywords {
  /// Common axis, dimension, and table labels used by ToolKit display output.
  public static let keyWords: [String] = [
    "x", "y",
    "X", "Y",
    "w", "h",
    "W", "H",
    
    ":", ",",

    "Row", "ROW",
    "Rows", "ROWS",

    "Column", "COL",
    "Columns", "COLS",

  ]
}
