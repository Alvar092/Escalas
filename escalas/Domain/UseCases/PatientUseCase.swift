//
//  GetPatientHistoryUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 1/12/25.
//

import Foundation

protocol GetPatientUseCaseProtocol {
    var patientRepository: PatientRepositoryProtocol {get set}
    
    func getPatients() async throws-> [Patient]
}

final class GetPatientUseCase: GetPatientUseCaseProtocol {
    var patientRepository: PatientRepositoryProtocol
    
    init(patientRepository: PatientRepositoryProtocol) {
        self.patientRepository = patientRepository
    }
    
    func getPatients() async throws -> [Patient] {
        try await patientRepository.getAll()
    }
}


