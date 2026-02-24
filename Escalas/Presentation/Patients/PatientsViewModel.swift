//
//  PatientViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import Foundation

@Observable
final class PatientViewModel {

    var patients: [Patient] = []
    
    @ObservationIgnored
    private var getPatientsUseCase: GetPatientsUseCaseProtocol
    private var createPatientUseCase: CreatePatientUseCaseProtocol
    
    
    init(getPatientsUseCase: GetPatientsUseCaseProtocol,
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
        AnalyticsManager.log(.patientCreated)
    }
}
