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
    private var deletePatientUseCase: DeletePatientUseCaseProtocol
    
    
    init(getPatientsUseCase: GetPatientsUseCaseProtocol,
         createPatientUseCase: CreatePatientUseCaseProtocol,
         deletePatientUseCase: DeletePatientUseCaseProtocol
    ) {
        self.getPatientsUseCase = getPatientsUseCase
        self.createPatientUseCase = createPatientUseCase
        self.deletePatientUseCase = deletePatientUseCase
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
    
    func deletePatient(id: UUID) async throws {
        try await deletePatientUseCase.deletePatient(by: id)
        try await loadPatients()
    }
}
