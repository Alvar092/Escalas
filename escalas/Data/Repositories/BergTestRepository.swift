//
//  BergTestRepository.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import SwiftData

final class BergTestRepository: BergTestRepositoryProtocol {
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(_ test: BergTest) async throws {
        let entity = try test.toEntity(context: modelContext)
    }
    
    func getAll() async throws -> [BergTest] {
        <#code#>
    }
    
    func getByPatient(_ patientID: UUID) async throws -> [BergTest] {
        <#code#>
    }
    
    func getByID(_ id: UUID) async throws {
        <#code#>
    }
    
    func update(_ test: BergTest) async throws {
        <#code#>
    }
    
    
}



