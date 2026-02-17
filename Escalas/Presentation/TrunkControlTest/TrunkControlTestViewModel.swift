//
//  TrunkControlTestViewModel.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 17/2/26.
//

import Foundation

@Observable
final class TrunkControlTestViewModel {
    
    private var useCase: SaveTrunkControlTestUseCaseProtocol
    
    var test: TrunkControlTest
    var items: [TrunkControlTestItem]
    
    init(useCase: SaveTrunkControlTestUseCaseProtocol, test: TrunkControlTest) {
        self.useCase = useCase
        self.test = test
        self.items = test.items
    }
    
    var currentItemIndex: Int = 0
    var selectedScore: Int?
    
    var currentItem: TrunkControlTestItem {
        items[currentItemIndex]
    }
    
    var isCompleted = false
    var navigateToResultView = false
    
    var currentItemDefinition: TrunkControlItemDefinition {
        guard let definition = TrunkControlTestCatalog.definitions[currentItem.itemType] else {
            fatalError("No definition found for item type \(currentItem.itemType)")
        }
        return definition
    }
    
    var scoreOptions: [TrunkControlScoreOption] {
        currentItemDefinition.scoringOptions
    }
    
    var currentItemScore: Int? {
        currentItem.score
    }
    
    var hasSelectedScore: Bool {
        selectedScore != nil
    }
    
    var totalScore: Int {
        items.compactMap{ $0.score }.reduce(0, +)
    }
    
    var progress: String {
        "\(currentItemIndex + 1) / \(items.count)"
    }
    
    func selectScore(_ score: Int) {
        selectedScore = score
        items[currentItemIndex].score = score
    }
    
    func isOptionSelected(_ option: TrunkControlScoreOption) -> Bool {
        selectedScore == option.score
    }
    
    var isLastItem: Bool {
        currentItemIndex == items.count - 1
    }
    
    func nextItem() {
        guard currentItemIndex < items.count - 1 else {return}
        currentItemIndex += 1
        selectedScore = items[currentItemIndex].score
    }
    
    func backItem() {
        if currentItemIndex > 0 {
            currentItemIndex -= 1
            selectedScore = items[currentItemIndex].score
        }
    }
    
    func finishTest() async throws {
        guard items.allSatisfy({ $0.score != nil }) else { return }
          
          test.items = items
          try await useCase.saveTrunkControlTest(test: test)
          isCompleted = true
          navigateToResultView = true
    }
}
