//
//  MotricityIndexRepository.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 5/2/26.
//

import Foundation
import SwiftData

final class MotricityIndexRepository: MotricityIndexRepositoryProtocol {
    
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    
    func save(_ test: MotricityIndex) async throws {
        let patientID = test.patientID
        
        let descriptor = FetchDescriptor<PatientEntity>(predicate: #Predicate { $0.id == patientID }
        )
        
        guard let patientEntity = try modelContext.fetch(descriptor).first else {
            throw NSError(domain: "Patient not found", code: 404)
        }
        
        let entity = try test.toEntity(patientEntity: patientEntity)
        modelContext.insert(entity)
        try modelContext.save()
    }
    
    func getAll() async throws -> [MotricityIndex] {
        let descriptor = FetchDescriptor<MotricityIndexEntity>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return try entities.map { try $0.toDomain() }
    }
    
    func getByPatient(_ patientID: UUID) async throws -> [MotricityIndex] {
        let descriptor = FetchDescriptor<MotricityIndexEntity>(
            predicate: #Predicate { $0.patient.id == patientID },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return try entities.map { try $0.toDomain() }
    }
    
    func getByID(_ id: UUID) async throws -> MotricityIndex? {
        let descriptor = FetchDescriptor<MotricityIndexEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try modelContext.fetch(descriptor).first else {
            return nil
        }
        return try entity.toDomain()
    }
    
    func update(_ test: MotricityIndex) async throws {
        let id = test.id

        let descriptor = FetchDescriptor<MotricityIndexEntity>(
            predicate: #Predicate { $0.id == id }
        )

        if let entity = try modelContext.fetch(descriptor).first {
            entity.date = test.date
            entity.side = test.side.rawValue
            entity.itemsData = try JSONEncoder().encode(test.items)
            try modelContext.save()
        }
    }
}
