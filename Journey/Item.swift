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
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
