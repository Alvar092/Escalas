//
//  PatientRespository.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 2/12/25.
//

import Foundation
import SwiftData

final class PatientRespository: PatientRepositoryProtocol {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func save(_ patient: Patient) async throws {
        let id = patient.id
        
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == id }
        )
        
        if let existing = try modelContext.fetch(descriptor).first {
            existing.name = patient.name
            existing.dateOfBirth = patient.dateOfBirth
        } else {
            let entity = try patient.toEntity()
            modelContext.insert(entity)
        }
        
        try modelContext.save()
    }
    
    func getAll() async throws -> [Patient] {
        let descriptor = FetchDescriptor<PatientEntity>(
            sortBy: [SortDescriptor(\.dateOfBirth, order: .reverse)]
        )
        let entities = try modelContext.fetch(descriptor)
        return try entities.map { try $0.toDomain() }
    }
    
    func getByID(_ id: UUID) async throws -> Patient? {
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try modelContext.fetch(descriptor).first else {
            return nil
        }
        return try entity.toDomain()
    }
    
    func delete(_ id: UUID) async throws {
      
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try modelContext.fetch(descriptor).first else {
            throw NSError(domain: "Patient not found", code: 404)
        }
        modelContext.delete(entity)
        try modelContext.save()
    }
    
    func update(_ patient: Patient) async throws {
        let id = patient.id
        
        let descriptor = FetchDescriptor<PatientEntity>(
            predicate: #Predicate { $0.id == id }
        )
        if let entity = try modelContext.fetch(descriptor).first {
            entity.name = patient.name
            entity.dateOfBirth = patient.dateOfBirth
            try modelContext.save()
        }
    }
}







// ------- MOCK -------

final class MockPatientRepository: PatientRepositoryProtocol {

    private var patients: [Patient]

    init(initialPatients: [Patient] = []) {
        self.patients = initialPatients
    }

    func save(_ patient: Patient) async throws {
        if let index = patients.firstIndex(where: { $0.id == patient.id }) {
            patients[index] = patient
        } else {
            patients.append(patient)
        }
    }

    func getAll() async throws -> [Patient] {
        patients
    }

    func getByID(_ id: UUID) async throws -> Patient? {
        patients.first { $0.id == id }
    }

    func delete(_ id: UUID) async throws {
        guard let index = patients.firstIndex(where: { $0.id == id }) else {
            throw MockRepositoryError.notFound
        }
        patients.remove(at: index)
    }

    func update(_ patient: Patient) async throws {
        guard let index = patients.firstIndex(where: { $0.id == patient.id }) else {
            throw MockRepositoryError.notFound
        }
        patients[index] = patient
    }
}

enum MockRepositoryError: Error {
    case notFound
}

// Mocks para previews y tests
let mockRepo = MockPatientRepository(initialPatients: [Patient.patient1, Patient.patient2,Patient.patient3])
