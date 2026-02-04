//
//  Item.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 30/11/25.
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
