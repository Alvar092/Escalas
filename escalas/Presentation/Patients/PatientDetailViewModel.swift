//
//  PatientDetailViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

final class PatientDetailViewModel {
    
    var patient: Patient
    private(set) var history: PatientHistory
    
    private var getTestsUseCase: GetPatientTestsUseCase
    
    init(patient: Patient, history: PatientHistory, getTestsUseCase: GetPatientTestsUseCase) {
        self.patient = patient
        self.history = history
        self.getTestsUseCase = getTestsUseCase
    }
    
    var tests: [any ClinicalTestProtocol] {
        history.allTests
    }
    
    @MainActor
    func getPatientTests() async throws {
        history = try await getTestsUseCase.getPatientHistory(patientID: patient.id)
    }
}
