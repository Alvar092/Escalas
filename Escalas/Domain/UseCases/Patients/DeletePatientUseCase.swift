//
//  DeletePatientUseCase.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 26/2/26.
//

import Foundation

protocol DeletePatientUseCaseProtocol {
    var patientsRepository: PatientRepositoryProtocol { get set }
    
    func deletePatient(by ID: UUID) async throws
}

final class DeletePatientUseCase: DeletePatientUseCaseProtocol {
    
    var patientsRepository: any PatientRepositoryProtocol
    
    init(patientsRepository: any PatientRepositoryProtocol) {
        self.patientsRepository = patientsRepository
    }
    
    func deletePatient(by ID: UUID) async throws {
        try await patientsRepository.delete(ID)
    }
    
    
}
