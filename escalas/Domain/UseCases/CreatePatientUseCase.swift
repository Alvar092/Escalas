//
//  CreatePatientUseCase.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 5/12/25.
//

import Foundation

protocol CreatePatientUseCaseProtocol {
    var patientRepository: PatientRepositoryProtocol { get set }
    
    func savePatient(patient: Patient) async throws 
}

final class CreatePatientUseCase: CreatePatientUseCaseProtocol {
    var patientRepository: any PatientRepositoryProtocol
    
    init(patientRepository: any PatientRepositoryProtocol) {
        self.patientRepository = patientRepository
    }
    
    func savePatient(patient: Patient) async throws {
        try await patientRepository.save(patient)
    }
    
    
}
