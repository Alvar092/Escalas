//
//  BergTestViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

@Observable
final class BergTestViewModel {
    
    let test: BergTest
    var items: [BergItem]
    
    // Indice de pregunta
    var currentItemIndex: Int = 0
    
    // Respuesta seleccionada
    var selectedScore: Int?
    
    // Pregunta actual
    var currentItem: BergItem {
        items[currentItemIndex]
    }
    
    init(test: BergTest) {
        self.test = test
        self.items = test.items
    }
    
    // Obtiene el enunciado y las opciones de respuesta
    var currentItemDefinition: BergItemDefinition {
        guard let definition = BergItemCatalog.definitions[currentItem.itemType] else {
            fatalError("No definition found for item type \(currentItem.itemType)")
        }
        return definition
    }
    
    // Opciones de respuesta del item
    var scoreOptions: [BergScoreOption] {
        currentItemDefinition.scoringOptions
    }
    
    // Puntuación seleccionada si ya se ha contestado
    var currentItemScore: Int? {
        currentItem.score
    }
    
    
    var hasSelectedScore: Bool {
        selectedScore != nil
    }
    
    // Marcador global
    var totalScore: Int {
        items.compactMap{ $0.score }.reduce(0, +)
    }
    
    // Número de pregunta
    var progress: String {
        "\(currentItemIndex + 1) / \(items.count)"
    }
    
    var canGoNext: Bool {
        currentItem.score != nil
    }
    
    var isLastItem: Bool {
        currentItemIndex == items.count - 1
    }
    
    // Actualiza la UI para indicar que respuesta se ha seleccionado
    func selectScore(_ score: Int) {
        selectedScore = score
        items[currentItemIndex].score = score
    }
    
    // Determina si un item se ha seleccionado
    func isOptionSelected(_ option: BergScoreOption) -> Bool {
        selectedScore == option.score
    }
    
    func backItem() {
        if currentItemIndex > 0 {
            currentItemIndex -= 1
            selectedScore = items[currentItemIndex].score
        }
    }
    
    func nextItem() {
        guard currentItemIndex < items.count - 1 else {return}
        currentItemIndex += 1
        selectedScore = items[currentItemIndex].score
    }
}
