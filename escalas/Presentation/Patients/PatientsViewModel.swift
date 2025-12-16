//
//  PatientViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import Foundation
import Combine
 
// Init VM empty and configure after recive environment in view 

@Observable
final class PatientViewModel {

    var patients: [Patient] = []
    
    private var getPatientsUseCase: GetPatientUseCaseProtocol
    private var createPatientUseCase: CreatePatientUseCaseProtocol
    
    
    init(getPatientsUseCase: GetPatientUseCaseProtocol,
         createPatientUseCase: CreatePatientUseCaseProtocol
    ) {
        self.getPatientsUseCase = getPatientsUseCase
        self.createPatientUseCase = createPatientUseCase
    }
  
    @MainActor
    func loadPatients() async throws {
        patients = try await getPatientsUseCase.getPatients()
    }
    
    func createPatient(newName: String, dateOfBirth: Date) async throws {
        let newPatient = Patient(id: UUID(), name: newName, dateOfBirth: dateOfBirth)
        try await createPatientUseCase.savePatient(patient: newPatient)
    }
}
