//
//  GetPatientHistoryUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation

protocol PatientUseCaseProtocol {
    var patientRepository: PatientRepositoryProtocol {get set}
    
    func getPatients() async throws-> [Patient]
}

final class PatientUseCase: PatientUseCaseProtocol {
    var patientRepository: PatientRepositoryProtocol
    
    init(patientRepository: PatientRepositoryProtocol) {
        self.patientRepository = patientRepository
    }
    
    func getPatients() async throws -> [Patient] {
        try await patientRepository.getAll()
    }
}
