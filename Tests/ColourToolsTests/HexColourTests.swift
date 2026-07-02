import ColourTools
import CoreTools
import Testing

struct HexColourTests {
  @Test
  func parsesShortRGBHex() throws {
    let colour = try #require(RGBColour(hex: "#0F8"))

    #expect(colour.red == 0)
    #expect(colour.green == 1)
    #expect(colour.blue.isApproximatelyEqual(to: 0x88 / 255.0))
    #expect(colour.alpha == 1)
  }

  @Test
  func parsesShortRGBAHex() throws {
    let colour = try #require(RGBColour(hex: "#0F88"))

    #expect(colour.red == 0)
    #expect(colour.green == 1)
    #expect(colour.blue.isApproximatelyEqual(to: 0x88 / 255.0))
    #expect(colour.alpha.isApproximatelyEqual(to: 0x88 / 255.0))
  }

  @Test
  func parsesLongRGBAHexThroughSharedParser() throws {
    let colour = try #require(RGBColour(hex: "00FF0080"))
    let components = try #require(HexColor.components(from: "00FF0080"))

    #expect(colour.red == components.r)
    #expect(colour.green == components.g)
    #expect(colour.blue == components.b)
    #expect(colour.alpha == components.a)
    #expect(colour.alpha.isApproximatelyEqual(to: 128.0 / 255.0))
  }

  @Test
  func rejectsInvalidHex() {
    #expect(RGBColour(hex: "not-a-colour") == nil)
    #expect(HexColor.components(from: "#12") == nil)
    #expect(HexColor.components(from: "#FFFFFG") == nil)
  }
}
