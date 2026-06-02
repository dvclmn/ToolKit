//
//  Collection.swift
//  Collection
//
//  Created by Dave Coleman on 17/12/2024.
//


// MARK: - Navigate by Index
extension BidirectionalCollection {
  public func nextIndex(
    after index: Index,
    wrapping: Bool = true,
  ) -> Index? {
    guard !isEmpty else { return nil }

    let next = self.index(after: index)
    guard next != endIndex else {
      return wrapping ? startIndex : nil
    }
    return next
  }

  public func previousIndex(
    before index: Index,
    wrapping: Bool = true,
  ) -> Index? {
    guard !isEmpty else { return nil }

    guard index != startIndex else {
      return wrapping ? self.index(before: endIndex) : nil
    }
    return self.index(before: index)
  }
}

// MARK: - Navigate by Element
extension BidirectionalCollection where Element: Equatable {
  public func nextElement(
    after element: Element,
    wrapping: Bool = true,
  ) -> Element? {
    guard
      let i = firstIndex(of: element),
      let next = nextIndex(after: i, wrapping: wrapping)
    else { return nil }

    return self[next]
  }

  public func previousElement(
    before element: Element,
    wrapping: Bool = true,
  ) -> Element? {
    guard
      let i = firstIndex(of: element),
      let prev = previousIndex(before: i, wrapping: wrapping)
    else { return nil }

    return self[prev]
  }
}

