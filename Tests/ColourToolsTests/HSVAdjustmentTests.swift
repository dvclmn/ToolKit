import ColourTools
import CoreTools
import Foundation
import Testing

struct HSVAdjustmentTests {
  @Test
  func applyingAddsOnlySpecifiedDeltasAndNormalisesTheResult() {
    let colour = HSVColour(h: 0.9, s: 0.5, v: 0.8, alpha: 0.4, name: "Base")
    let adjustment = HSVAdjustment(hueDegrees: 72, saturation: 0.8)

    let adjusted = colour.applying(adjustment)

    #expect(adjusted.hue.isApproximatelyEqual(to: 0.1, within: 0.000_000_000_001))
    #expect(adjusted.saturation == 1)
    #expect(adjusted.brightness == colour.brightness)
    #expect(adjusted.alpha == colour.alpha)
    #expect(adjusted.name == colour.name)
    #expect(adjusted.id == colour.id)
  }

  @Test
  func replacingUsesAbsoluteValuesRatherThanDeltas() {
    let colour = HSVColour(h: 0.2, s: 0.4, v: 0.6)

    let replaced = colour.replacing(hue: 1.2, brightness: -0.5)

    #expect(replaced.hue.isApproximatelyEqual(to: 0.2, within: 0.000_000_000_001))
    #expect(replaced.saturation == 0.4)
    #expect(replaced.brightness == 0)
    #expect(replaced.id == colour.id)
  }

  @Test
  func combinedHueAdjustmentsRemainDeltasUntilApplied() throws {
    let combined = [
      HSVAdjustment(h: -0.05),
      HSVAdjustment(h: -0.10),
    ].combined(with: 1)
    let hueDelta = try #require(combined.hue)

    #expect(hueDelta.isApproximatelyEqual(to: -0.15, within: 0.000_000_000_001))

    let adjusted = HSVColour(h: 0.1, s: 0.5, v: 0.5).adjust(by: combined)
    #expect(adjusted.hue.isApproximatelyEqual(to: 0.95, within: 0.000_000_000_001))
  }

  @Test
  func interpolatingHueDeltasUsesStraightArithmetic() throws {
    let adjustment = HSVAdjustment(h: -0.1).interpolated(
      towards: HSVAdjustment(h: 0.1),
      amount: 0.5
    )
    let hue = try #require(adjustment.hue)

    #expect(hue.isApproximatelyEqual(to: 0, within: 0.000_000_000_001))
  }

  @Test
  func decodingLegacyStrengthPreservesTheStoredDeltas() throws {
    let legacyJSON = """
      {
        "hue": -0.05,
        "saturation": 0.2,
        "brightness": -0.1,
        "strength": 0.5
      }
      """
    let data = try #require(legacyJSON.data(using: .utf8))

    let adjustment = try JSONDecoder().decode(HSVAdjustment.self, from: data)

    #expect(adjustment.hue == -0.05)
    #expect(adjustment.saturation == 0.2)
    #expect(adjustment.brightness == -0.1)
  }
}
