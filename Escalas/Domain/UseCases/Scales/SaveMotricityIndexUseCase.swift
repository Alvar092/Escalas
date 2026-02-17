//
//  SaveMotricityIndexUseCase.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 11/2/26.
//

import Foundation


protocol SaveMotricityIndexUseCaseProtocol {
    
    var repository: MotricityIndexRepositoryProtocol {get set}
    
    func saveMotricityIndex(test: MotricityIndex) async throws
}

final class SaveMotricityIndexUseCase: SaveMotricityIndexUseCaseProtocol {
    var repository: any MotricityIndexRepositoryProtocol
    
    init(repository: any MotricityIndexRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveMotricityIndex(test: MotricityIndex) async throws {
        try await repository.save(test)
    }
}


final class MockSaveMotricityIndexUseCase: SaveMotricityIndexUseCaseProtocol {
    var repository: any MotricityIndexRepositoryProtocol
    
    init(repository: any MotricityIndexRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveMotricityIndex(test: MotricityIndex) async throws {
        try await repository.save(test)
    }
    

}
