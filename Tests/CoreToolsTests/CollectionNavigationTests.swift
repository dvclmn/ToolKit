import CoreTools
import Testing

struct CollectionNavigationTests {
  @Test
  func testZeroStepStillRequiresCurrentValueToBePresent() {
    #expect([1, 2, 3].value(steppingFrom: 2, by: 0) == 2)
    #expect([1, 2, 3].value(steppingFrom: 99, by: 0) == nil)
    #expect([Int]().value(steppingFrom: 1, by: 0) == nil)
  }

  @Test
  func testNonWrappingStepReturnsNilWhenTargetIsBeyondBounds() {
    let values = [1, 2, 3]

    #expect(values.value(steppingFrom: 2, by: 1) == 3)
    #expect(values.value(steppingFrom: 2, by: -1) == 1)
    #expect(values.value(steppingFrom: 2, by: 99) == nil)
    #expect(values.value(steppingFrom: 2, by: -99) == nil)
    #expect(values.value(steppingFrom: 3, by: 1) == nil)
    #expect(values.value(steppingFrom: 1, by: -1) == nil)
  }

  @Test
  func testWrappingStepUsesModuloMovement() {
    let values = [1, 2, 3]

    #expect(values.value(steppingFrom: 2, by: 2, wrapping: true) == 1)
    #expect(values.value(steppingFrom: 2, by: -2, wrapping: true) == 3)
    #expect(values.value(steppingFrom: 2, by: 99, wrapping: true) == 2)
    #expect(values.value(steppingFrom: 2, by: -99, wrapping: true) == 2)
  }

  @Test
  func testExactNavigationUsesCollectionOrder() {
    let values = [30, 10, 20]

    #expect(values.nextElement(after: 30, wrapping: false) == 10)
    #expect(values.previousElement(before: 20, wrapping: false) == 10)
    #expect(values.nextElement(after: 20, wrapping: false) == nil)
    #expect(values.previousElement(before: 30, wrapping: false) == nil)
    #expect(values.nextValue(after: 30, wrapping: false) == 10)
    #expect(values.previousValue(before: 20, wrapping: false) == 10)
  }

  @Test
  func testExactValueSteppingUsesCollectionOrder() {
    let values = [30, 10, 20]

    #expect(30.stepped(in: values, direction: .up) == 10)
    #expect(20.stepped(in: values, direction: .down) == 10)
    #expect(20.stepped(in: values, direction: .up) == nil)
    #expect(20.stepped(in: values, direction: .up, wrapping: true) == 30)
  }

  @Test
  func testLooseSteppingUsesSortedValueOrderForExactAndInexactValues() {
    let values = [30, 10, 20]

    #expect(values.nextValueLoosely(after: 10) == 20)
    #expect(values.nextValueLoosely(after: 20) == 30)
    #expect(values.nextValueLoosely(after: 30) == nil)
    #expect(values.nextValueLoosely(after: 30, wrapping: true) == 10)

    #expect(values.previousValueLoosely(before: 10) == nil)
    #expect(values.previousValueLoosely(before: 10, wrapping: true) == 30)
    #expect(values.previousValueLoosely(before: 20) == 10)
    #expect(values.previousValueLoosely(before: 25) == 20)
  }

  @Test
  func testLooseValueSteppingUsesSortedValueOrder() {
    let values = [30, 10, 20]

    #expect(20.steppedLoosely(in: values, direction: .up) == 30)
    #expect(25.steppedLoosely(in: values, direction: .up) == 30)
    #expect(20.steppedLoosely(in: values, direction: .down) == 10)
    #expect(15.steppedLoosely(in: values, direction: .down) == 10)
  }

  @Test
  func testCaseCyclableUsesSharedNavigationBoundaries() {
    #expect(NavigationCase.first.toNext() == .second)
    #expect(NavigationCase.third.toNext() == .first)
    #expect(NavigationCase.third.toNext(wrapping: false) == .third)

    #expect(NavigationCase.third.toPrevious() == .second)
    #expect(NavigationCase.first.toPrevious() == .third)
    #expect(NavigationCase.first.toPrevious(wrapping: false) == .first)
  }
}

private enum NavigationCase: CaseCyclable {
  case first
  case second
  case third

  static let defaultCase: Self = .first
}
