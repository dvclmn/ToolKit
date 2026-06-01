//
//  IconGalleryViewable.swift
//  ToolKit
//
//  Created by Dave Coleman on 31/5/2026.
//

public protocol IconGalleryViewable: Identifiable, RawRepresentable, CaseIterable where Self.RawValue == String {
  var id: String { get }
  var reference: String { get }
}
