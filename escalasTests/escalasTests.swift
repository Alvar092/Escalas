//
//  escalasTests.swift
//  escalasTests
//
//  Created by Álvaro Entrena Casas on 30/11/25.
//

import Testing
@testable import escalas
import SwiftData
import Foundation

struct escalasTests {
    @Suite("Data Testing") struct DataTests{
        @Suite("Repositories", .serialized) struct RepositoriesTest {
            
            var container: ModelContainer
            var context: ModelContext
            var sut: PatientRespository
            
            init() throws {
                // for: Que modelos guardar
                // configurations: como guardarlo, isStoredInMemoryOnly lo deja en RAM, se borra al acabar el test
                container = try ModelContainer(for: PatientEntity.self, BergTestEntity.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                )
                
                context = ModelContext(container)
                
                sut = PatientRespository(modelContext: context)
            }
            
            func createOnePatient(name: String = "Perico Palotes", dateOfBirth: Date = Date()) -> Patient {
                return Patient(id: UUID(), name: name, dateOfBirth: dateOfBirth)
            }
            
            @Test("SavePatient")
            func savePatientTest() async throws {
                
                // GIVEN
                let patient = createOnePatient()
                
                // WHEN
                try await sut.save(patient)
                
                // THEN
                let descriptor = FetchDescriptor<PatientEntity>()
                let entities = try context.fetch(descriptor)
                
                #expect(entities.count == 1)
                #expect(entities.first?.name == "Perico Palotes")
            }
            
            @Test("GetAllPatients")
            func getAllPatientsTest() async throws {
                // GIVEN
                let oldPatient = Patient(
                       id: UUID(),
                       name: "Paciente Viejo",
                       dateOfBirth: Calendar.current.date(byAdding: .year, value: -80, to: Date())!
                   )
                   let youngPatient = Patient(
                       id: UUID(),
                       name: "Paciente Joven",
                       dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!
                   )
                
                // WHEN
                try await sut.save(oldPatient)
                try await sut.save(youngPatient)
                
                let patients = try await sut.getAll()
                
                // THEN
                #expect(patients.count == 2)
                #expect(patients.first?.name == "Paciente Joven")
                #expect(patients.last?.name == "Paciente Viejo")
            }
            
            @Test("GetPatientByID")
            func getPatientByID() async throws {
                // GIVEN
                let patient = createOnePatient()
                
                // WHEN
                try await sut.save(patient)
                
                let result = try await sut.getByID(patient.id)
                #expect(patient.name == result?.name)
                #expect(patient.dateOfBirth == result?.dateOfBirth)
            }
        }
    }

}
