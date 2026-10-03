//
//  ContainerValue.swift
//  Components
//
//  Created by Dave Coleman on 21/11/2024.
//

import SwiftUI

// TODO: Show example usage (see DCKit > DCUI)
public protocol ContainerValueCompatible {
  associatedtype Value

  @available(macOS 15, iOS 18, *)
  var containerKeyPath: WritableKeyPath<ContainerValues, Value> { get }
}


extension View {
  @ViewBuilder
  public func containerValueCompatible<T: ContainerValueCompatible>(
    _ type: T,
    _ value: T.Value,
  ) -> some View {
    if #available(macOS 15, iOS 18, *) {
      self.containerValue(type.containerKeyPath, value)
    } else {
      self
    }
  }
}
