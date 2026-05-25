//
//  CGSize+Conversion.swift
//  ToolKit
//
//  Created by Dave Coleman on 10/1/2026.
//


import Foundation

extension CGSize {

  public var toCGRectZeroOrigin: CGRect { CGRect(origin: .zero, size: self) }
  public var toCGPoint: CGPoint { CGPoint(x: width, y: height) }

}
