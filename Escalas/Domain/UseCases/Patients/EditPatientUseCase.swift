//
//  EditPatientUseCase.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 27/2/26.
//

import Foundation

protocol EditPatientUseCaseProtocol {
    var patientsRepository: PatientRepositoryProtocol { get set }
    
    func updatePatient(patient: Patient) async throws
}

final class EditPatientUseCase: EditPatientUseCaseProtocol {
    
    var patientsRepository: any PatientRepositoryProtocol
    
    init(patientsRepository: any PatientRepositoryProtocol) {
        self.patientsRepository = patientsRepository
    }
    
    func updatePatient(patient: Patient) async throws {
        try await patientsRepository.update(patient)
    }
}
