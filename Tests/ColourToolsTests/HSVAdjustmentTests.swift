import ColourTools
import CoreTools
import Testing

struct HSVAdjustmentTests {
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
}
