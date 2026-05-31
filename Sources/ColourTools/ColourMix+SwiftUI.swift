//
//  ColourMix+SwiftUI.swift
//  ToolKit
//
//  Created by Dave Coleman on 23/5/2026.
//

import SwiftUI
import CoreTools

extension ColourMix {
  public var colour: Color { base.withMix(mix, mixAmount) }
}
