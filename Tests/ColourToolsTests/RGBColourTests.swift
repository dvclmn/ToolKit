import ColourTools
import CoreTools
import Foundation
import Testing

struct RGBColourTests {
  @Test
  func from255NormalisesEightBitComponents() {
    let colour = RGBColour.from255(128, 64, 32, name: "Sample")

    #expect(colour.red.isApproximatelyEqual(to: 128.0 / 255.0))
    #expect(colour.green.isApproximatelyEqual(to: 64.0 / 255.0))
    #expect(colour.blue.isApproximatelyEqual(to: 32.0 / 255.0))
    #expect(colour.alpha == 1.0)
    #expect(colour.is255)
    #expect(colour.name == "Sample")
  }

  @Test
  func from255PreservesFullIntensity() {
    let colour = RGBColour.from255(255, 255, 255)

    #expect(colour.red == 1.0)
    #expect(colour.green == 1.0)
    #expect(colour.blue == 1.0)
  }

  @Test
  func from255ClampsEightBitComponentsBeforeNormalising() {
    let colour = RGBColour.from255(-10, 128, 300)

    #expect(colour.red == 0)
    #expect(colour.green.isApproximatelyEqual(to: 128.0 / 255.0))
    #expect(colour.blue == 1)
  }

  @Test
  func initialiserClampsNormalisedComponents() {
    let colour = RGBColour(red: -0.25, green: 0.5, blue: 1.4, alpha: 2)

    #expect(colour.red == 0)
    #expect(colour.green == 0.5)
    #expect(colour.blue == 1)
    #expect(colour.alpha == 1)
    #expect(colour.areAllComponentsNormalised)
  }

  @Test
  func equalityAndHashingUseComponentsNotGeneratedIdentity() {
    let first = RGBColour(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4, name: "First")
    let second = RGBColour(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4, name: "Second")

    #expect(first.id != second.id)
    #expect(first == second)
    #expect(Set([first, second]).count == 1)
  }

  @Test
  func codingOmitsGeneratedIdentityAndDecodesLegacyIdentityPayload() throws {
    let colour = RGBColour(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4, name: "Stored")
    let encoded = try JSONEncoder().encode(colour)
    let object = try #require(JSONSerialization.jsonObject(with: encoded) as? [String: Any])

    #expect(!object.keys.contains("id"))

    let legacyJSON = """
      {
        "id": "\(UUID().uuidString)",
        "red": 0.1,
        "green": 0.2,
        "blue": 0.3,
        "alpha": 0.4,
        "name": "Stored",
        "is255": false
      }
      """
    let legacyData = try #require(legacyJSON.data(using: .utf8))
    let decoded = try JSONDecoder().decode(RGBColour.self, from: legacyData)

    #expect(decoded == colour)
    #expect(decoded.name == "Stored")
  }
}
