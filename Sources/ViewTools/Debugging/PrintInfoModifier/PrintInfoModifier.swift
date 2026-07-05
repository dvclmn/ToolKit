//
//  File.swift
//
//
//  Created by Dave Coleman on 23/7/2024.
//

import CoreTools
import SwiftUI

public struct PrintInfoModifier: ViewModifier {

  let info: LocationInfo

  public func body(content: Content) -> some View {
    content
      .onAppear {
        guard !isPreview else { return }
        print(info.locationInfo)
      }
  }
}
extension View {
  public func printInfo(_ info: LocationInfo) -> some View {
    self.modifier(PrintInfoModifier(info: info))
  }
}
