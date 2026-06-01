//
//  OpenInFinder.swift
//  ToolKit
//
//  Created by Dave Coleman on 17/6/2025.
//

#if canImport(AppKit)
import AppKit

/// Opens Finder with a file selected.
public struct OpenInFinder {
  /// Reveals `url` in Finder.
  public static func `open`(_ url: URL) {
    NSWorkspace.shared.selectFile(url.path, inFileViewerRootedAtPath: "")
  }
}
#endif
