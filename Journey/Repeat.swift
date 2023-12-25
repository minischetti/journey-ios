//
//  Repeat.swift
//  Journey
//
//  Created by Dominic Minischetti on 12/25/23.
//

import Foundation
import SwiftData

enum RepeatUnit: String {
    case day
    case week
    case month
    case year
}

@Model
final class Repeat {
    var interval: Int
    var unit: String
    var end: Date?
    var count: Int?

    init(interval: Int, unit: String, end: Date?, count: Int?) {
        self.interval = interval
        self.unit = unit
        self.end = end
        self.count = count
    }
}
