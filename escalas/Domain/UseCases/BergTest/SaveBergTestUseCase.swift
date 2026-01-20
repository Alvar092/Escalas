//
//  SaveBergTestUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//


import Foundation

protocol SaveBergTestUseCaseProtocol {
    
    var repository: BergTestRepositoryProtocol {get set}
    
    func saveBerg(test: BergTest) async throws
}

final class SaveBergTestUseCase: SaveBergTestUseCaseProtocol {
    var repository: any BergTestRepositoryProtocol
    
    init(repository: any BergTestRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveBerg(test: BergTest) async throws {
        try await repository.save(test)
    }    
}
