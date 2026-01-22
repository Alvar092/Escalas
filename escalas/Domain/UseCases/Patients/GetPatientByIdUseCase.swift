//
//  GetPatientByIdUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import Foundation

protocol GetPatientByIdUseCaseProtocol {
    var patientsRepository: PatientRepositoryProtocol { get set }
    
    func getPatient(by ID: UUID) async throws -> Patient?
}

final class GetPatientByIdUseCase: GetPatientByIdUseCaseProtocol {
    
    var patientsRepository: any PatientRepositoryProtocol
    
    init(patientsRepository: any PatientRepositoryProtocol) {
        self.patientsRepository = patientsRepository
    }
    
    func getPatient(by ID: UUID) async throws -> Patient? {
        try await patientsRepository.getByID(ID)
    }
}
