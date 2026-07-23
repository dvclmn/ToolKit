//
//  Contrastable.swift
//  ToolKit
//
//  Created by Dave Coleman on 11/10/2025.
//

public protocol HSVAdjustable {
  var toHSV: HSVColour { get }
  init(fromHSV hsv: HSVColour)

  func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose,
    chroma: ColourChroma,
  ) -> Self

  func contrastColour(modification: ColourModification?) -> Self
}

extension HSVAdjustable {

  /// Adjustment by delta. Increase/decrease by amount provided.
  /// `0` = no adjustment. Hue is wrapped after applying the delta;
  /// saturation and brightness are clamped to `0...1`.
  public func adjust(
    hue: Double,
    saturation: Double,
    brightness: Double
  ) -> Self {
    Self(
      fromHSV: toHSV.applying(
        HSVAdjustment(
          hue: hue,
          saturation: saturation,
          brightness: brightness
        )
      )
    )
  }

  /// Applies an HSV delta, wrapping hue and clamping saturation/brightness.
  public func adjust(
    by adjustment: HSVAdjustment
  ) -> Self {
    Self(fromHSV: toHSV.applying(adjustment))
  }

  /// Set a new value, returns new instance
  /// If value is `nil`, that property doesn't get touched. Hue is wrapped after
  /// setting; saturation and brightness are clamped to `0...1`.
  public func set(
    hue: Double?,
    saturation: Double?,
    brightness: Double?
  ) -> Self {
    Self(
      fromHSV: toHSV.replacing(
        hue: hue,
        saturation: saturation,
        brightness: brightness
      )
    )
  }

  /// This will 'pass through', returning `self` if `modification` is `nil`
  public func contrastColour(modification: ColourModification?) -> Self {
    guard let modification else { return self }

    return self.contrastColour(
      strength: modification.strength,
      purpose: modification.purpose,
      chroma: modification.chroma
    )
  }

}

extension HSVAdjustable where Self: LuminanceReadable {

  public func contrastColour(
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose = .legibility,
    chroma: ColourChroma = .standard,
  ) -> Self {

    guard strength.adjustmentStrength > 0 else { return self }

    let adjustment = HSVAdjustment.applyingModifiers(
      for: self,
      strength: strength,
      purpose: purpose,
      chroma: chroma
    )

    return Self(fromHSV: toHSV.applying(adjustment))

  }
}
