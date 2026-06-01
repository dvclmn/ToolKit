//
//  BFP+Zoom.swift
//  ToolKit
//
//  Created by Dave Coleman on 13/1/2026.
//

import Foundation

extension BinaryFloatingPoint {

  /// Removes a multiplicative zoom factor from this value.
  ///
  /// A factor of `1` leaves the value unchanged; `2` treats the value as being
  /// drawn at 200% zoom.
  public func removingZoomFactor(_ factor: Self) -> Self {
    guard factor.isFinite, factor != 0 else { return self }
    return self / factor
  }

  /// Removes a normalised zoom amount by mapping `0...1` into `1...maxFactor`.
  public func removingZoomNormalised(
    _ normalised: Self,
    maxFactor: Self = 2,
  ) -> Self {
    let clamped = normalised.clamped(to: 0...1)
    let factor = 1 + clamped * (maxFactor - 1)
    return self / factor
  }

  /// Removes a zoom amount expressed as a percentage in `0...100`.
  public func removingZoomPercent(_ percent: Self) -> Self {
    precondition(percent >= 0 && percent <= 100, "Expects a 0...100 percent value, received: \(percent)")

    let normalised = percent / 100
    return self / (1 + normalised)
  }

  /// Keeps line width visually consistent across zoom levels.
  /// Optically, lines can feel slightly heavier at small zoom levels,
  /// and thinner when zoomed in close. Use `sensitivity`
  /// to adjust the feel of the weight at either extreme.
  ///
  /// A sensitivity of `0`/`nil` does not change the apparent
  /// line weight at all. A value of `1` will produce thinner lines
  /// at low zooms, and thicker lines at high zooms.
  public func removingZoom(
    _ zoom: Self,
    across range: ClosedRange<Self>? = nil,
    sensitivity: Self? = nil,
  ) -> Self {
    guard zoom.isGreaterThanZero, range?.isGreaterThanZero ?? false else {
      return self
    }
    let effectiveZoom = range.map { zoom.clamped(to: $0) } ?? zoom

    if let sensitivity {
      let s = sensitivity.clamped(to: 0...1)
      return self * Self(pow(Double(effectiveZoom), Double(s - 1)))
    }

    return self / effectiveZoom
  }

  /// Applies non-linear zoom scaling to provide better control at different zoom levels.
  ///
  /// - Parameters:
  ///   - zoom: The current zoom level.
  ///   - range: The valid zoom range.
  ///   - lowSensitivityThreshold: Zoom level below which sensitivity is reduced.
  ///   - highSensitivityThreshold: Zoom level above which sensitivity is increased.
  ///   - curve: The power curve factor. Higher values create a stronger curve.
  /// - Returns: The transformed zoom scale.
  public static func nonLinearZoomScale(
    _ zoom: Double,
    in range: ClosedRange<Double>,
    lowSensitivityThreshold: Double = 1.0,
    highSensitivityThreshold: Double = 5.0,
    curve: Double = 1.5,
  ) -> Double {

    guard range.isGreaterThanZero,
      curve > 0
    else { return zoom }

    let upper = range.upperBound
    let lower = range.lowerBound

    // Normalise the zoom level to the `0...1` range. This also clamps to `range`.
    let normalised = zoom.normalised(in: range)

    // Calculate threshold positions in normalised space, clamping to avoid invalid values.
    let low = lowSensitivityThreshold.clamped(to: range)
    let high = highSensitivityThreshold.clamped(to: range)

    let lowThresholdNorm = (low - lower) / (upper - lower)
    let highThresholdNorm = (high - lower) / (upper - lower)

    let transformedZoom: Double

    if normalised <= lowThresholdNorm {
      // Low zoom range: reduce sensitivity for a slower response.
      let localNorm = normalised / lowThresholdNorm

      // Use the curve to slow down response.
      let slowed = CGFloat(curve).slowResponse(localNorm)

      transformedZoom = slowed * lowThresholdNorm

    } else if normalised >= highThresholdNorm {
      // High zoom range: increase sensitivity for a faster response.
      let localNorm = (normalised - highThresholdNorm) / (1.0 - highThresholdNorm)

      // Use the inverse curve for faster response.
      let faster = CGFloat(curve).fastResponse(localNorm)
      transformedZoom = highThresholdNorm + faster * (1.0 - highThresholdNorm)

    } else {
      // Middle range: linear scaling.
      transformedZoom = normalised
    }

    // Convert back to the actual zoom range.
    return transformedZoom.denormalised(in: range)
  }

  /// Applies non-linear zoom scaling using a single curve parameter.
  ///
  /// - Parameters:
  ///   - zoom: The current zoom level.
  ///   - range: The valid zoom range.
  ///   - sensitivity: Controls the curve. Values below `1` reduce low-zoom sensitivity;
  ///     values above `1` increase it.
  /// - Returns: The transformed zoom scale.
  public static func simpleNonLinearZoomScale(
    _ zoom: Double,
    range: ClosedRange<Double>,
    sensitivity: Double = 1.3,
  ) -> Double {
    guard sensitivity > 0 else { return zoom }
    let normalised = zoom.normalised(in: range)
    let transformed = pow(normalised, sensitivity)
    return transformed.denormalised(in: range)
  }

  /// Applies a curve where `self` is the exponent.
  func slowResponse(_ x: Self) -> Self {
    Self(pow(CGFloat(x), CGFloat(self)))
  }

  /// Applies the inverse of a curve where `self` is the exponent.
  func fastResponse(_ x: Self) -> Self {
    Self(pow(CGFloat(x), CGFloat(1 / self)))
  }

}
