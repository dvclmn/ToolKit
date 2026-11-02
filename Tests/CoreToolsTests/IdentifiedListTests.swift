//
//  IdentifiedListTests.swift
//  ToolKit
//
//  Created by Dave Coleman on 2/11/2026.
//

import CoreTools
import Foundation
import Testing

struct IdentifiedListTests {
  private struct Item: Identifiable, Codable, Equatable, Comparable {
    var id: Int
    var value: Int = 0

    static func < (lhs: Self, rhs: Self) -> Bool { lhs.id < rhs.id }
  }

  private enum Failure: Error { case expected }

  private func expectConsistent(_ list: IdentifiedList<Item>) {
    #expect(Set(list.map(\.id)).count == list.count)
    for item in list {
      #expect(list[id: item.id] == item)
    }
  }

  @Test func duplicateInitialisationAndAppendKeepFirstPositionAndLastValue() {
    var list = IdentifiedList([Item(id: 2), Item(id: 1), Item(id: 2, value: 7)])
    #expect(list.map(\.id) == [2, 1])
    #expect(list[id: 2]?.value == 7)
    list.append(Item(id: 1, value: 9))
    #expect(list.map(\.id) == [2, 1])
    #expect(list[id: 1]?.value == 9)
    expectConsistent(list)
  }

  @Test func explicitUpdateOrAppendReportsReplacement() {
    var list = IdentifiedList<Item>()
    #expect(list.updateOrAppend(Item(id: 1)) == nil)
    list.append(Item(id: 2))
    #expect(list.updateOrAppend(Item(id: 1, value: 8)) == Item(id: 1))
    #expect(list.map(\.id) == [1, 2])
    #expect(list[id: 1]?.value == 8)
    expectConsistent(list)
  }

  @Test func positionalCollisionKeepsBothIDsReachable() {
    var list: IdentifiedList<Item> = [Item(id: 1), Item(id: 2), Item(id: 3)]
    list[0] = Item(id: 2, value: 8)
    #expect(Array(list) == [Item(id: 2, value: 8), Item(id: 1), Item(id: 3)])
    expectConsistent(list)
    #expect(list.remove(id: 2) == Item(id: 2, value: 8))
    #expect(list[id: 2] == nil)
    expectConsistent(list)
  }

  @Test func positionalReplacementWithNewIDRemovesOldLookup() {
    var list: IdentifiedList<Item> = [Item(id: 1), Item(id: 2)]
    list[0] = Item(id: 3)
    #expect(list[id: 1] == nil)
    #expect(list.map(\.id) == [3, 2])
    list[0].value = 5
    #expect(list[id: 3]?.value == 5)
    expectConsistent(list)
  }

  @Test func idSubscriptInsertsUpdatesAndRemoves() {
    var list = IdentifiedList<Item>()
    list[id: 1] = Item(id: 1)
    list[id: 2] = Item(id: 2)
    list[id: 1]?.value += 1
    #expect(list.map(\.id) == [1, 2])
    #expect(list[id: 1]?.value == 1)
    list[id: 99]?.value = 3
    #expect(list.count == 2)
    list[id: 99] = nil
    list[id: 1] = nil
    #expect(list[id: 1] == nil)
    #expect(list.map(\.id) == [2])
    expectConsistent(list)
  }

  @Test func removalRepairsEveryShiftedIndex() {
    var list = IdentifiedList((0..<6).map { Item(id: $0) })
    for id in [0, 3, 5, 1, 4, 2] {
      #expect(list.remove(id: id)?.id == id)
      #expect(list[id: id] == nil)
      expectConsistent(list)
    }
    #expect(list.isEmpty)
    #expect(list.remove(id: 99) == nil)
  }

  @Test func copyingPreservesIndependentValueElements() {
    let original: IdentifiedList<Item> = [Item(id: 1), Item(id: 2)]
    var copy = original
    copy[id: 1]?.value = 7
    copy.remove(id: 2)
    copy.append(Item(id: 3))
    #expect(Array(original) == [Item(id: 1), Item(id: 2)])
    #expect(Array(copy) == [Item(id: 1, value: 7), Item(id: 3)])
    expectConsistent(original)
    expectConsistent(copy)
  }

  @Test func reorderingPreservesLookupsThroughGenericCollections() {
    func reverse<C: MutableCollection & BidirectionalCollection>(_ collection: inout C) {
      collection.reverse()
    }
    func sort<C: MutableCollection & RandomAccessCollection>(_ collection: inout C)
    where C.Element: Comparable {
      collection.sort()
    }
    var list = IdentifiedList((0..<20).map { Item(id: $0) })
    reverse(&list)
    #expect(list.map(\.id) == Array((0..<20).reversed()))
    expectConsistent(list)
    sort(&list)
    #expect(list.map(\.id) == Array(0..<20))
    expectConsistent(list)
    list.swapAt(0, 19)
    expectConsistent(list)
    list.swapAt(0, 0)
    expectConsistent(list)
    let pivot = list.partition { $0.id.isMultiple(of: 2) }
    #expect(list[..<pivot].allSatisfy { !$0.id.isMultiple(of: 2) })
    #expect(list[pivot...].allSatisfy { $0.id.isMultiple(of: 2) })
    expectConsistent(list)
    list.sort()
    #expect(list.map(\.id) == Array(0..<20))
    expectConsistent(list)
  }

  @Test func throwingAlgorithmsLeaveLookupUsable() {
    var list = IdentifiedList((0..<20).reversed().map { Item(id: $0) })
    var comparisons = 0
    #expect(throws: Failure.self) {
      try list.sort {
        comparisons += 1
        if comparisons == 5 { throw Failure.expected }
        return $0 < $1
      }
    }
    #expect(Set(list.map(\.id)) == Set(0..<20))
    expectConsistent(list)
    var visits = 0
    #expect(throws: Failure.self) {
      try list.partition {
        visits += 1
        if visits == 5 { throw Failure.expected }
        return $0.id.isMultiple(of: 2)
      }
    }
    #expect(Set(list.map(\.id)) == Set(0..<20))
    expectConsistent(list)
  }

  @Test func codingUsesAnArrayAndPreservesOrder() throws {
    let values = [Item(id: 2, value: 7), Item(id: 1, value: 4)]
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let list = try decoder.decode(IdentifiedList<Item>.self, from: encoder.encode(values))
    #expect(Array(list) == values)
    let decodedArray = try decoder.decode([Item].self, from: encoder.encode(list))
    #expect(decodedArray == values)
    expectConsistent(list)
    let empty = try decoder.decode(IdentifiedList<Item>.self, from: Data("[]".utf8))
    #expect(empty.isEmpty)
  }

  @Test func decodingRejectsDuplicateIDs() throws {
    let data = try JSONEncoder().encode([Item(id: 1), Item(id: 1, value: 9)])
    #expect {
      try JSONDecoder().decode(IdentifiedList<Item>.self, from: data)
    } throws: { error in
      guard case DecodingError.dataCorrupted = error else { return false }
      return true
    }
  }

  @Test func codingConformancesAreIndependent() throws {
    struct EncodeOnly: Identifiable, Encodable { let id: Int }
    struct DecodeOnly: Identifiable, Decodable { let id: Int }
    let list: IdentifiedList<EncodeOnly> = [EncodeOnly(id: 7)]
    let data = try JSONEncoder().encode(list)
    let decoded = try JSONDecoder().decode(IdentifiedList<DecodeOnly>.self, from: data)
    #expect(decoded.first?.id == 7)
  }
}
