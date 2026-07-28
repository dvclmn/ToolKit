//
//  AnimationTimeline.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import CoreTools
import SwiftUI

public struct AnimationTimeline<Content: View>: View {
  @Environment(\.isPaused) private var isPaused
  @Environment(\.frameRate) private var frameRate

  let isNotifyingPaused: Bool
  let frameRateOverride: FrameRate?
  let content: (TimeInterval) -> Content

  public init(
    frameRate: FrameRate? = nil,
    isNotifyingPaused: Bool = true,
    @ViewBuilder content: @escaping (TimeInterval) -> Content,
  ) {
    self.isNotifyingPaused = isNotifyingPaused
    self.frameRateOverride = frameRate
    self.content = content
  }

  public var body: some View {

    TimelineView(
      .animation(
        minimumInterval: frameRateOverride?.rate ?? frameRate.wrappedValue.rate,
        paused: isPaused.wrappedValue,
      )
    ) { context in
      content(context.date.timeIntervalSinceReferenceDate)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .debugText {
          if isNotifyingPaused && isPaused.wrappedValue {
            "Timeline is Paused"
          }
        }
    }
  }
}
