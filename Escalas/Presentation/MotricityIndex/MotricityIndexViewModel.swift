//
//  MotricityIndexViewModel.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 11/2/26.
//

import Foundation

@Observable
final class MotricityIndexViewModel {
    
    @ObservationIgnored
    private var useCase: SaveMotricityIndexUseCaseProtocol
    
    var test: MotricityIndex
    var items: [MotricityIndexItem]
    
    var currentItemIndex: Int = 0
    var selectedScore: Int?
    
    var currentItem: MotricityIndexItem {
        items[currentItemIndex]
    }
    
    var isCompleted = false
    var navigateToResultView = false
    
    init(useCase: SaveMotricityIndexUseCaseProtocol, test: MotricityIndex) {
        self.useCase = useCase
        self.test = test
        self.items = test.items
    }
    
    var currentItemDefinition: MotricityItemDefinition {
        guard let definition = MotricityIndexCatalog.definitions[currentItem.itemType] else {
            fatalError("No definition found for item type \(currentItem.itemType)")
        }
        return definition
    }
    
    var scoreOptions: [MotricityScoreOption] {
        currentItemDefinition.scoringOptions
    }
    
    var currentItemScore: Int? {
        currentItem.score
    }
    
    var hasSelectedScore: Bool {
        selectedScore != nil
    }
    
    var progress: String {
        "\(currentItemIndex + 1) / \(items.count)"
    }
    
    // En el ViewModel
    var upperLimbScore: Int {
        items.filter { $0.itemType.isUpperLimb }
            .reduce(0) { $0 + ($1.score ?? 0) } + 1
    }

    var lowerLimbScore: Int {
        items.filter { $0.itemType.isLowerLimb }
            .reduce(0) { $0 + ($1.score ?? 0) } + 1
    }
    
    func selectScore(_ score: Int) {
        selectedScore = score
        items[currentItemIndex].score = score
    }
    
    func isOptionSelected(_ option: MotricityScoreOption) -> Bool {
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
        guard test.side != nil, items.allSatisfy({ $0.score != nil }) else { return }
          
          test.items = items
          try await useCase.saveMotricityIndex(test: test)
          isCompleted = true
          navigateToResultView = true
    }
}
