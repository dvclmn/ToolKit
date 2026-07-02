import ColourTools
import CoreTools
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
}
