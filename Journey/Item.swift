//
//  Item.swift
//  Journey
//
//  Created by Dominic Minischetti on 12/24/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var id: UUID
    var title: String
    var content: String?
//    var status: Status
    var creationDate: Date
    var dueDate: Date?
    var parents: [String]?
    var children: [Item]?
    var repeats: Repeat?

    init(title: String, content: String, status: Status, creationDate: Date, dueDate: Date) {
        self.id = UUID()
        self.title = title
        self.content = content
//        self.status = status
        self.creationDate = creationDate
        self.dueDate = dueDate
    }
}
