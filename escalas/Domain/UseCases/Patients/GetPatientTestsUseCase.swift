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
    
    init(patientRepository: PatientRepositoryProtocol, bergTestRepository: BergTestRepositoryProtocol) {
        self.patientRepository = patientRepository
        self.bergTestRepository = bergTestRepository
    }
    
    func getPatientHistory(patientID: UUID) async throws -> PatientHistory {
        guard let patient = try await patientRepository.getByID(patientID) else {
            throw PatientHistoryError.patientNotFound
        }
        
        let bergTests = try await bergTestRepository.getByPatient(patientID)
        
        return PatientHistory(patient: patient, bergTests: bergTests)
    }
}


enum PatientHistoryError: Error {
    case patientNotFound
    case testNotFound
}


final class MockGetPatientTestsUseCase: GetPatientTestsUseCaseProtocol {
    
    func getPatientHistory(patientID: UUID) async throws -> PatientHistory {
        // Devuelve un historial mock ya creado
        switch patientID {
        case Patient.patient1.id:
            return PatientHistory(patient: Patient.patient1, bergTests: [BergTest.patient1])
        case Patient.patient2.id:
            return PatientHistory(patient: Patient.patient2, bergTests: [BergTest.patient2])
        case Patient.patient3.id:
            return PatientHistory(patient: Patient.patient3, bergTests: [BergTest.patient3])
        default:
            return PatientHistory(patient: Patient.patient1, bergTests: [])
        }
    }
}
