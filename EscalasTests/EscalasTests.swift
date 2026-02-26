//
//  escalasTests.swift
//  escalasTests
//
//  Created by Álvaro Entrena Casas on 30/11/25.
//

import Testing
@testable import Escalas
import SwiftData
import Foundation

struct EscalasTests {
    @Suite("Data Testing") struct DataTests{
        @Suite("Repositories", .serialized) struct RepositoriesTests {
            struct TestHelper {
                static func createInMemoryContainer() throws -> (ModelContainer, ModelContext) {
                    let container = try ModelContainer(
                        for: PatientEntity.self, BergTestEntity.self,
                        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
                    )
                    let context = ModelContext(container)
                    return (container, context)
                }
                
                static func createOnePatient(name: String = "Perico Palotes", dateOfBirth: Date = Date()) -> Patient {
                    return Patient(id: UUID(), name: name, dateOfBirth: dateOfBirth)
                }
                
            }
            
            @Suite("PatientsRepository") struct PatientRespositoryTest {
                
                var container: ModelContainer
                var context: ModelContext
                var sut: PatientRespository
                
                init() throws {
                    (container, context) = try TestHelper.createInMemoryContainer()
                    sut = PatientRespository(modelContext: context)
                }
                
                @Test("SavePatient")
                func savePatientTest() async throws {
                    
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    
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
                func getPatientByIDTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    
                    // WHEN
                    try await sut.save(patient)
                    
                    let result = try await sut.getByID(patient.id)
                    #expect(patient.name == result?.name)
                    #expect(patient.dateOfBirth == result?.dateOfBirth)
                }
                
                @Test("DeletePatient")
                func deletePatientTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    
                    // WHEN
                    try await sut.save(patient)
                    try await sut.delete(patient.id)
                    let patients = try await sut.getAll()
                    
                    // THEN
                    #expect(patients.isEmpty == true)
                }
                
                @Test("UpdatePatient")
                @MainActor
                func updatePatientTest() async throws {
                    // GIVEN
                    var patient = TestHelper.createOnePatient()
                    try await sut.save(patient)
                    
                    // WHEN
                    patient.name = "Pedro Macias"
                    try await sut.update(patient)
                    
                    // THEN
                    let patients = try await sut.getAll()
                    #expect(patients.first?.name == "Pedro Macias")
                }
            }
            @Suite("BergTestRepository") struct BergTestRepositoryTest {
                
                var container: ModelContainer
                var context: ModelContext
                var patientRepository: PatientRespository
                var sut: BergTestRepository
                
                init() throws {
                    (container, context) = try TestHelper.createInMemoryContainer()
                    patientRepository = PatientRespository(modelContext: context)
                    sut = BergTestRepository(modelContext: context)
                }
                
                func createEmptyItems() -> [BergItem] {
                    return BergItemType.allCases.map { itemType in
                        BergItem(
                            id: UUID(),
                            itemType: itemType,
                            score: 0,
                            timeRecorded: nil
                        )
                    }
                }
                
                func createOneBergTest(date: Date = Date(), patientID: UUID) -> BergTest {
                    let items = createEmptyItems()
                    return BergTest(
                        id: UUID(),
                        date: date,
                        patientID: patientID,
                        items: items)
                }
                
                @Test("SaveBerg")
                func saveBergTest() async throws{
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    let patientID = await patient.id
                    let test = createOneBergTest(patientID: patientID)
                    try await patientRepository.save(patient)
                    
                    // WHEN
                    try await sut.save(test)
                    
                    // THEN
                    let descriptor = FetchDescriptor<BergTestEntity>()
                    let entities = try context.fetch(descriptor)
                    #expect(entities.count == 1)
                }
                
                @Test("GetAllBergs")
                func getAllBergTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    let patientID = await patient.id
                    let test1 = createOneBergTest(patientID: patientID)
                    let test2 = createOneBergTest(patientID: patientID)
                    try await patientRepository.save(patient)
                    
                    // WHEN
                    try await sut.save(test1)
                    try await sut.save(test2)
                    
                    
                    // THEN
                    let allTests = try await sut.getAll()
                    #expect(allTests.count == 2)
                }
                
                @Test("GetBergByPatient")
                func getBergByPatientTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    let patientID = await patient.id
                    let test = createOneBergTest(patientID: patientID)
                    
                    // WHEN
                    try await patientRepository.save(patient)
                    try await sut.save(test)
                    
                    // THEN
                    let result = try await sut.getByPatient(patientID)
                    #expect(result.count == 1)
                }
                
                @Test("GetBergByID")
                func getBergByIDTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    let patientID = await patient.id
                    let test = createOneBergTest(patientID: patientID)
                    let testID = await test.id
                    // WHEN
                    try await patientRepository.save(patient)
                    try await sut.save(test)
                    
                    // THEN
                    let result = try await sut.getByID(testID)
                    #expect(result?.patientID == patientID)
                    #expect(result?.totalScore == test.totalScore)
                }
                
                @Test("UpdateBerg")
                @MainActor
                func updateBergTest() async throws {
                    // GIVEN
                    let patient = TestHelper.createOnePatient()
                    let patientID = patient.id
                    var test = createOneBergTest(patientID: patientID)
                    
                    try await patientRepository.save(patient)
                    // WHEN
                    test.items[0].score = 3
                    try await sut.save(test)
                    
                    // THEN
                    let result = try await sut.getByPatient(patientID)
                    let item = result.first?.items.first
                    #expect(item?.score == 3)
                    
                }
            }
        }//Repos
    } // Data
    
    @Suite("Domaing Testing") struct DomainTest {
        @Suite("UseCases") struct UseCasesTests {
            @Test("getPatients")
            @MainActor
            func getPatientsTest() async throws {
                // GIVEN
                let repo = mockRepo
                let useCase = GetPatientsUseCase(patientRepository: repo)
                
                // WHEN
                let result = try await useCase.getPatients()
                
                // THEN
                #expect(result.count == 3)
            }
            
            @Test("createPatient")
            @MainActor
            func createPatientTest() async throws {
                // GIVEN
                let repo = MockPatientRepository()
                let useCase = CreatePatientUseCase(patientRepository: repo)
                let patient = Patient.patient1
                
                // WHEN
                try await useCase.savePatient(patient: patient)
                // THEN
                #expect(repo.patients.count == 1)
                #expect(repo.patients.first?.id == patient.id)
            }
            
            @Test("getPatientTests")
            @MainActor
            func getPatientHistoryTest() async throws {
                // GIVEN
                let patient = Patient.patient1
                let patientsRepo = mockRepo
                
                let bergTest = BergTest.patient1
                let bergRepo = mockBergRepo
                let motricityRepo = MockMotricityIndexRepository()
                let trunkRepo = MockTrunkControlTestRepository()
                
                let useCase = GetPatientTestsUseCase(patientRepository: patientsRepo, bergTestRepository: bergRepo, motricityIndexRepository: motricityRepo , trunkControlTestRepository: trunkRepo)
                
                // WHEN
                let history = try await useCase.getPatientHistory(patientID: patient.id)
                
                // THEN
                #expect(history.patient.id == patient.id)
                #expect(history.bergTests.count == 1)
                #expect(history.bergTests.first?.id == bergTest.id)
                
            }
        }//UseCases
    }//Domain
    
    @Suite("Presentation Testing") struct PresentationTest{
        @Suite("ScaleMenuViewModel") struct ScaleMenuViewModelTests {
            
            @Test("InitVM")
            @MainActor
            func initialization() async throws {
                let vm = ScaleMenuViewModel(testType: .berg)
                
                #expect(vm.testType == .berg)
                #expect(vm.selectedPatient == nil)
                #expect(vm.showingPatientSelection == false)
                #expect(vm.isStartButtonEnabled == false)
            }
            
            @Test("SelectPatient")
            @MainActor
            func selectPatient() async throws {
                let vm = ScaleMenuViewModel(testType: .berg)
                let patient = Patient.patient1
                
                vm.selectPatient(patient)
                
                #expect(vm.selectedPatient?.name == patient.name)
                #expect(vm.isStartButtonEnabled == true)
                #expect(vm.showingPatientSelection == false)
            }
            
            @Test("DisplayName")
            @MainActor
            func patientDisplayName() async throws {
                let vm = ScaleMenuViewModel(testType: .berg)
                let patient = Patient.patient1
                
                #expect(vm.patientDisplayName == "Seleccionar paciente")
                
                vm.selectPatient(patient)
                #expect(vm.patientDisplayName == patient.name)
            }
        }
        @Suite("ScaleResultViewModel") struct ScaleResultViewModelTests {
            @Test("InitVM")
            @MainActor
            func initialization() async throws {
                let vm = ScaleResultViewModel(test: BergTest.patient1,
                                              useCase: GetPatientByIdUseCase(
                                                patientsRepository: MockPatientRepository()
                                              )
                )
                
                #expect(vm.test.testType == .berg)
                #expect(vm.patient == nil)
            }
            
            @Test("GetPatient")
            @MainActor
            func getPatient() async throws {
                let repo = MockPatientRepository(initialPatients: [Patient.patient1])
                let vm = ScaleResultViewModel(test: BergTest.patient1,
                                              useCase: GetPatientByIdUseCase(
                                                patientsRepository: repo
                                              )
                )
                
                try await vm.getPatient()
                
                #expect(vm.patient == Patient.patient1)
            }
        }
    }
}


// GIVEN

// WHEN

// THEN
