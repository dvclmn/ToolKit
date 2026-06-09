//
//  StateView+Example.swift
//  Components
//
//  Created by Dave Coleman on 7/2/2025.
//

import CoreTools
import SwiftUI

struct StateViewExample: View {

  @State private var controlSize: ControlSize = .regular
  @State private var showsAddtionalContent: Bool = false
  var body: some View {

    ScrollView {

      VStack(spacing: 60) {
        ForEach(ControlSize.allCases) { size in
          StateViewComparison(
            size: size,
            title: content(size).0,
            icon: content(size).1,
            message: content(size).2,
            showsAddtionalContent: showsAddtionalContent,
          )
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    .controlSize(controlSize)
    .symbolVariant(.fill)
    .symbolRenderingMode(.hierarchical)

    //    .padding(40)
    .frame(width: 600, height: 700)
    .background(.black.opacity(0.6))
    .toolbar {
      ToolbarItem {
        //        LabeledContent("Show additional content") {
        Toggle(isOn: $showsAddtionalContent) {
          Text("Show additional content")
        }
        .toggleStyle(.checkbox)
        .padding(.horizontal)
        //            .labelsHidden()
        //        }
        //          .toggleStyle(.automatic)
      }
    }
    //    .safeAreaInset(edge: .bottom) {
    //      Picker("Size", selection: $controlSize) {
    //        ForEach(ControlSize.allCases) { size in
    //          Text(size.displayName).tag(size)
    //        }
    //      }
    //      .pickerStyle(.segmented)
    //
    //    }
  }
}
extension StateViewExample {
  private func content(_ size: ControlSize) -> (String, String, String) {
    return (
      "This is a title",
      Icons.boat.icon,
      "I'm a view with \(size.displayName) size.",
    )
  }
}

#if DEBUG
#Preview {
  StateViewExample()
}
#endif
