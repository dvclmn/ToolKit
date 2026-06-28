//
//  Person.swift
//  ToolKit
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation
//import ViewTools

extension SampleContent {

  struct Person: Identifiable {
    let id = UUID()
    let givenName: String
    let familyName: String
    let emailAddress: String

    var fullName: String { givenName + " " + familyName }

    static let people = [
      Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
      Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
      Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
      Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com"),
    ]
  }

  
  struct TableItem: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
    var isActive: String
    var group: TableItemGroup = .sidebar

    static let items: [TableItem] = [
      TableItem(
        id: UUID(),
        name: "Apple",
        icon: "burst",
        isActive: "true",
        group: .sidebar
      ),
      TableItem(
        id: UUID(),
        name: "Banana",
        icon: "rectangle.tophalf.inset.filled",
        isActive: "false",
        group: .icons
      ),
      TableItem(
        id: UUID(),
        name: "Cherry",
        icon: "ladybug",
        isActive: "true",
        group: .sidebar
      ),
    ]
  }

  enum TableItemGroup: String, Hashable {
    case sidebar
    case icons

  }

}
