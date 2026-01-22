//
//  BergTestViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/1/26.
//

import Foundation

@Observable
final class BergTestViewModel {
    
    @ObservationIgnored
    private var useCase: SaveBergTestUseCaseProtocol
    
    var test: BergTest
    var items: [BergItem]
    
    private var timer: Timer?
    var isTimerRunning = false
    var elapsedTime: TimeInterval = 0
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let miliseconds = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 10)
        return String(format: "%02d:%02d.%01d", minutes,seconds,miliseconds)
    }
    
    // Indice de pregunta
    var currentItemIndex: Int = 0
    
    // Respuesta seleccionada
    var selectedScore: Int?
    
    // Pregunta actual
    var currentItem: BergItem {
        items[currentItemIndex]
    }
    
    // Estado del test
    var isCompleted = false
    var navigateToResultView = false
    
    init(useCase: SaveBergTestUseCaseProtocol,test: BergTest) {
        self.useCase = useCase
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
    
    func startTimer() {
        guard !isTimerRunning else { return }
        isTimerRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.elapsedTime += 0.1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        
        // Guardar el tiempo en el item
        items[currentItemIndex].timeRecorded = elapsedTime
        items[currentItemIndex].timeScoring()
        
        selectedScore = items[currentItemIndex].score
    }
    
    func resetTimer() {
        stopTimer()
        elapsedTime = 0
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
        
        if isTimerRunning {
            stopTimer()
        }
        
        if currentItemIndex > 0 {
            currentItemIndex -= 1
            selectedScore = items[currentItemIndex].score
            
            // Obtener el tiempo guardado en el item
            elapsedTime = items[currentItemIndex].timeRecorded ?? 0
        }
    }
    
    func nextItem() {
        
        if isTimerRunning {
            stopTimer()
        }
        
        guard currentItemIndex < items.count - 1 else {return}
        currentItemIndex += 1
        selectedScore = items[currentItemIndex].score
        
        // Obtener el tiempo guardado en el item
        elapsedTime = items[currentItemIndex].timeRecorded ?? 0
    }
    
    // Finalizar test
    func finishTest() async throws {
        test.items = items
        try await useCase.saveBerg(test: test)
        isCompleted = true
        navigateToResultView = true
    }
}
