//
//  SaveMotricityIndexUseCase.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 11/2/26.
//

import Foundation


protocol SaveTrunkControlTestUseCaseProtocol {
    
    var repository: TrunkControlTestRepositoryProtocol {get set}
    
    func saveTrunkControlTest(test: TrunkControlTest) async throws
}

final class SaveTrunkControlTestUseCase: SaveTrunkControlTestUseCaseProtocol {
    var repository: any TrunkControlTestRepositoryProtocol
    
    init(repository: any TrunkControlTestRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveTrunkControlTest(test: TrunkControlTest) async throws {
        try await repository.save(test)
    }
}


final class MockSaveTrunkControlTestUseCase: SaveTrunkControlTestUseCaseProtocol {
    var repository: any TrunkControlTestRepositoryProtocol
    
    init(repository: any TrunkControlTestRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveTrunkControlTest(test: TrunkControlTest) async throws {
        try await repository.save(test)
    }
    

}
