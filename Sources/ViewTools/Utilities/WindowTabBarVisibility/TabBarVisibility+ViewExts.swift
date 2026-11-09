//
//  WindowTabBarVisibility.swift
//  ToolKit
//
//  Created by Dave Coleman on 9/11/2026.
//

#if os(macOS)
import AppKit
import SwiftUI

extension View {
  /// Reads whether this view's containing window displays its native tab bar.
  ///
  /// This includes a tab bar shown manually for a single window. It does not
  /// count documents or inspect the application's key window.
  ///
  /// ```swift
  /// @State private var isTabBarVisible = false
  ///
  /// var body: some View {
  ///   EditorView()
  ///     .toolbarBackground(
  ///       isTabBarVisible ? .visible : .hidden,
  ///       for: .windowToolbar
  ///     )
  ///     .readWindowTabBarVisibility($isTabBarVisible)
  /// }
  /// ```
  ///
  /// Attach once at the root of each window's content and share the resulting
  /// state with child views as needed. Updates arrive asynchronously on the
  /// main queue, after attachment and AppKit window updates. Until attachment,
  /// and while detached, the binding retains its existing value.
  ///
  /// The reader checks the current tab group after each application window
  /// update, rather than relying on undocumented KVO notifications for
  /// `NSWindowTabGroup.isTabBarVisible`. Only changed values are written.
  @MainActor
  public func readWindowTabBarVisibility(_ isVisible: Binding<Bool>) -> some View {
    background {
      WindowTabBarVisibilityReader(isVisible: isVisible)
        .frame(width: 0, height: 0)
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
  }
}

#endif
