//
//  BergTestViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

final class BergTestViewModel {
    
    let patient: Patient
    var items: [BergItem]
    var currentItemIndex: Int   
    
    var currentItem: BergItem {
        items[currentItemIndex]
    }
    
    init(items: [BergItem], currentItemIndex: Int) {
        self.items = items
        self.currentItemIndex = currentItemIndex
    }
    
    var currentItemDefinition: BergItemDefinition {
        guard let definition = BergItemCatalog.definitions[currentItem.itemType] else {
            fatalError("No definition found for item type \(currentItem.itemType)")
        }
        return definition
    }
    
    var scoreOptions: [BergScoreOption] {
        currentItemDefinition.scoringOptions
    }
    
    var currentItemScore: Int? {
        currentItem.score
    }
    
    var totalScore: Int {
        items.compactMap{ $0.score }.reduce(0, +)
    }
    
    var progress: String {
        "\(currentItemIndex + 1) / \(items.count)"
    }
    
    var canGoNext: Bool {
        currentItem.score != nil
    }
    
    var isLastItem: Bool {
        currentItemIndex == items.count - 1
    }
}
