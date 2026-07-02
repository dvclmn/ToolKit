import ColourTools
import CoreTools
import Testing

struct LuminanceThresholdTests {
  @Test
  func thresholdClassifiesDarkAndLightColours() {
    #expect(RGBColour(red: 0, green: 0, blue: 0).luminanceThreshold(using: .wcag) == .dark)
    #expect(RGBColour(red: 1, green: 1, blue: 1).luminanceThreshold(using: .wcag) == .light)
  }

  @Test
  func thresholdHueAdjustmentsAreStoredAsUnitDeltasFromDegrees() throws {
    let darkAdjustment = LuminanceThreshold.dark.adjustment
    let lightAdjustment = LuminanceThreshold.light.adjustment
    let darkHue = try #require(darkAdjustment.hue)
    let lightHue = try #require(lightAdjustment.hue)

    #expect(darkHue.isApproximatelyEqual(to: -18.0 / 360.0))
    #expect(lightHue.isApproximatelyEqual(to: -16.0 / 360.0))
  }

  @Test
  func luminanceAdjustmentApplicationNormalisesResult() {
    let colour = HSVColour(h: 0.02, s: 0.5, v: 0.5)
    let adjusted = colour.adjust(by: LuminanceThreshold.dark.adjustment)

    #expect(adjusted.hue.isApproximatelyEqual(to: 0.97, within: 0.000_000_000_001))
    #expect(adjusted.saturation.isApproximatelyEqual(to: 0.49, within: 0.000_000_000_001))
    #expect(adjusted.brightness == 1)
  }
}
