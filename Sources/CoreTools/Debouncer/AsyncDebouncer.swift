//
//  AsyncDebouncer.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/3/2025.
//

import Foundation

/// Debounces asynchronous work by cancelling pending trailing-edge execution when
/// a newer request arrives.
///
/// This is a core scheduling primitive rather than a SwiftUI view helper. Store
/// the debouncer for at least as long as the work it coordinates; in SwiftUI,
/// `ViewTools` provides convenience APIs for holding and using debouncers from
/// views.
///
/// Use a separate instance for each independent task stream; calls made through
/// one debouncer share cancellation state.
@Observable
public final class AsyncDebouncer {
  private var task: Task<Void, Error>?

  /// Tracks the cooldown window used by leading-edge execution.
  private var cooldownTask: Task<Void, Error>?

  private let interval: Duration

  public init(interval: TimeInterval = 0.2) {
    self.interval = Duration.seconds(interval)
  }

  deinit {
    task?.cancel()
  }
}

extension AsyncDebouncer {

  /// Executes `action` after the debounce interval, cancelling any pending action.
  @MainActor
  public func execute(
    action: @escaping @MainActor @Sendable () async -> Void
  ) {
    // Cancel any previous task.
    task?.cancel()

    task = Task {
      // `Task.sleep` throws `CancellationError` when the task is cancelled.
      try await Task.sleep(for: interval)
      await action()
    }
  }

  /// Executes immediately (leading edge) if there isn't an active cooldown window.
  /// Subsequent calls within the cooldown window are ignored until the interval elapses.
  /// This behaves like a throttle with a leading edge.
  @MainActor
  public func executeLeading(
    action: @escaping @MainActor @Sendable () async -> Void
  ) {
    if cooldownTask != nil { return }
    task?.cancel()

    Task {
      await action()
    }

    cooldownTask = Task {
      try await Task.sleep(for: interval)
      cooldownTask = nil
    }
  }

  /// Executes the action either immediately (skipping the debounce delay)
  /// or with the standard trailing-edge debounce.
  /// - Parameters:
  ///   - shouldSkipDelay: When true, the action runs immediately (leading-edge).
  ///     When false, it uses the standard trailing-edge debounce.
  ///   - action: The asynchronous action to perform.
  @MainActor
  public func execute(
    immediateIf shouldSkipDelay: Bool,
    action: @escaping @Sendable () async -> Void,
  ) {
    if shouldSkipDelay {
      executeLeading(action: action)
    } else {
      execute(action: action)
    }
  }
}
