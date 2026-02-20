//
//  GetPatientTestsUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

protocol GetPatientTestsUseCaseProtocol {
    
    func getPatientHistory(patientID: UUID) async throws -> PatientHistory
}

final class GetPatientTestsUseCase: GetPatientTestsUseCaseProtocol {
    
    private let patientRepository: PatientRepositoryProtocol
    private let bergTestRepository: BergTestRepositoryProtocol
    private let motricityIndexRepository: MotricityIndexRepositoryProtocol
    private let trunkControlTestRepository: TrunkControlTestRepositoryProtocol
    
    init(patientRepository: PatientRepositoryProtocol, bergTestRepository: BergTestRepositoryProtocol,    motricityIndexRepository: MotricityIndexRepositoryProtocol,
         trunkControlTestRepository: TrunkControlTestRepositoryProtocol) {
        self.patientRepository = patientRepository
        self.bergTestRepository = bergTestRepository
        self.motricityIndexRepository = motricityIndexRepository
        self.trunkControlTestRepository = trunkControlTestRepository
    }
    
    func getPatientHistory(patientID: UUID) async throws -> PatientHistory {
        guard let patient = try await patientRepository.getByID(patientID) else {
            throw PatientHistoryError.patientNotFound
        }
        
        let bergTests = try await bergTestRepository.getByPatient(patientID)
        let motricityTests = try await motricityIndexRepository.getByPatient(patientID)
        let trunkTests = try await trunkControlTestRepository.getByPatient(patientID)
                
        
        return PatientHistory(
            patient: patient,
            bergTests: bergTests,
            motricityIndexTests: motricityTests,
            trunkControlTests: trunkTests)
    }
}


enum PatientHistoryError: Error {
    case patientNotFound
    case testNotFound
}


final class MockGetPatientTestsUseCase: GetPatientTestsUseCaseProtocol {
    
    func getPatientHistory(patientID: UUID) async throws -> PatientHistory {
           switch patientID {
           case Patient.patient1.id:
               return PatientHistory(
                   patient: Patient.patient1,
                   bergTests: [BergTest.patient1],
                   motricityIndexTests: [MotricityIndex.patient1],
                   trunkControlTests: [TrunkControlTest.patient1]
               )
           case Patient.patient2.id:
               return PatientHistory(
                   patient: Patient.patient2,
                   bergTests: [BergTest.patient2],
                   motricityIndexTests: [MotricityIndex.patient2],
                   trunkControlTests: [TrunkControlTest.patient2]
               )
           case Patient.patient3.id:
               return PatientHistory(
                   patient: Patient.patient3,
                   bergTests: [BergTest.patient3],
                   motricityIndexTests: [MotricityIndex.patient3],
                   trunkControlTests: [TrunkControlTest.patient3]
               )
           default:
               return PatientHistory(
                   patient: Patient.patient1,
                   bergTests: [],
                   motricityIndexTests: [],
                   trunkControlTests: []
               )
           }
       }}
