//
//  BergTestRepository.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//
import Foundation
import SwiftData

final class BergTestRepository: BergTestRepositoryProtocol {
    
    typealias Test = BergTest 
    
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // Saves a new Beg test in database
    func save(_ test: BergTest) async throws {
        let patientID = test.patientID
        
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == patientID }
        )
        
        guard let patientEntity = try modelContext.fetch(descriptor).first else {
            throw NSError(domain: "Patient not found", code: 404)
        }
        
        let entity = try test.toEntity(patientEntity: patientEntity)
        modelContext.insert(entity)
        try modelContext.save()
    }
    
    func getAll() async throws -> [BergTest] {
        let descriptor = FetchDescriptor<BergTestEntity>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return try entities.map { try $0.toDomain()}
    }
    
    func getByPatient(_ patientID: UUID) async throws -> [BergTest] {
        let descriptor = FetchDescriptor<BergTestEntity>(
            predicate: #Predicate { $0.patient.id == patientID },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return try entities.map { try $0.toDomain() }
    }
    
    func getByID(_ id: UUID) async throws -> BergTest? {
        let descriptor = FetchDescriptor<BergTestEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try modelContext.fetch(descriptor).first else {
            return nil
        }
        return try entity.toDomain()
    }
    
    func update(_ test: BergTest) async throws {
        let id = test.id
        
        let descriptor = FetchDescriptor<BergTestEntity>(
            predicate: #Predicate { $0.id == id }
        )
        if let entity = try modelContext.fetch(descriptor).first {
            entity.date = test.date
            entity.itemsData = try JSONEncoder().encode(test.items)
            try modelContext.save()
        }
    }
}

final class MockBergTestRepository: BergTestRepositoryProtocol {

    typealias Test = BergTest 
    
    private(set) var bergTests: [BergTest]

    init(initialTests: [BergTest] = []) {
        self.bergTests = initialTests
    }

    func save(_ test: BergTest) async throws {
        bergTests.append(test)
    }

    func getAll() async throws -> [BergTest] {
        bergTests.sorted { $0.date > $1.date }
    }

    func getByPatient(_ patientID: UUID) async throws -> [BergTest] {
        bergTests
            .filter { $0.patientID == patientID }
            .sorted { $0.date > $1.date }
    }

    func getByID(_ id: UUID) async throws -> BergTest? {
        bergTests.first { $0.id == id }
    }

    func update(_ test: BergTest) async throws {
        guard let index = bergTests.firstIndex(where: { $0.id == test.id }) else {
            return
        }
        bergTests[index] = test
    }
}

let mockBergRepo = MockBergTestRepository(initialTests: [BergTest.patient1, BergTest.patient2, BergTest.patient3])



