import ColourTools
import CoreTools
import Foundation
import Testing

struct HSVColourTests {
  @Test
  func initialiserWrapsHueAndClampsOtherComponents() {
    let colour = HSVColour(h: -0.25, s: -1, v: 1.2, alpha: -0.5)

    #expect(colour.hue == 0.75)
    #expect(colour.saturation == 0)
    #expect(colour.brightness == 1)
    #expect(colour.alpha == 0)
    #expect(colour.areAllComponentsNormalised)
  }

  @Test
  func adjustmentWrapsHueAndClampsSaturationBrightness() {
    let colour = HSVColour(h: 0.95, s: 0.9, v: 0.1)
    let adjusted = colour.adjust(by: HSVAdjustment(h: 0.1, s: 0.3, v: -0.3))

    #expect(adjusted.hue.isApproximatelyEqual(to: 0.05, within: 0.000_000_000_001))
    #expect(adjusted.saturation == 1)
    #expect(adjusted.brightness == 0)
  }

  @Test
  func equalityAndHashingUseComponentsNotGeneratedIdentity() {
    let first = HSVColour(h: 1.25, s: 1.2, v: -0.2, alpha: 2, name: "First")
    let second = HSVColour(h: 0.25, s: 1, v: 0, alpha: 1, name: "Second")

    #expect(first.id != second.id)
    #expect(first == second)
    #expect(Set([first, second]).count == 1)
  }

  @Test
  func codingOmitsGeneratedIdentityAndDecodesLegacyIdentityPayload() throws {
    let colour = HSVColour(h: 0.25, s: 0.5, v: 0.75, alpha: 0.8, name: "Stored")
    let encoded = try JSONEncoder().encode(colour)
    let object = try #require(JSONSerialization.jsonObject(with: encoded) as? [String: Any])

    #expect(!object.keys.contains("id"))

    let legacyJSON = """
      {
        "id": "\(UUID().uuidString)",
        "hue": 0.25,
        "saturation": 0.5,
        "brightness": 0.75,
        "alpha": 0.8,
        "name": "Stored"
      }
      """
    let legacyData = try #require(legacyJSON.data(using: .utf8))
    let decoded = try JSONDecoder().decode(HSVColour.self, from: legacyData)

    #expect(decoded == colour)
    #expect(decoded.name == "Stored")
  }

  @Test
  func rgbHSVRoundTripPreservesNormalisedComponents() {
    let samples = [
      RGBColour(red: 1, green: 0, blue: 0, alpha: 1),
      RGBColour(red: 0, green: 1, blue: 0, alpha: 0.75),
      RGBColour(red: 0, green: 0, blue: 1, alpha: 0.5),
      RGBColour(red: 0.25, green: 0.5, blue: 0.75, alpha: 0.33),
    ]

    for sample in samples {
      let roundTrip = sample.toHSV.toRGB

      #expect(roundTrip.red.isApproximatelyEqual(to: sample.red, within: 0.000_000_000_001))
      #expect(roundTrip.green.isApproximatelyEqual(to: sample.green, within: 0.000_000_000_001))
      #expect(roundTrip.blue.isApproximatelyEqual(to: sample.blue, within: 0.000_000_000_001))
      #expect(roundTrip.alpha.isApproximatelyEqual(to: sample.alpha, within: 0.000_000_000_001))
    }
  }

  @Test
  func undefinedHueConversionCanPreservePreviousHue() {
    let previous = HSVColour(h: 0.72, s: 1, v: 1)
    let converted = RGBColour.gray(0.4).toHSV(preservingHueFrom: previous)

    #expect(converted.hue == previous.hue)
    #expect(converted.saturation == 0)
    #expect(converted.brightness == 0.4)
  }
}
