//
//  ScaleMenuViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 18/12/25.
//

import Foundation
import Observation

@Observable
final class ScaleMenuViewModel {
    
    
    var selectedPatient: Patient?
    var selectedSide: BodySide?
    var showingPatientSelection = false
    let testType: TestType
    var createdTest: ClinicalTestProtocol?
    
    
    
    @ObservationIgnored
    private let createTestUseCase: CreateTestUseCaseProtocol
    
    init(testType: TestType, createTestUseCase: CreateTestUseCaseProtocol = CreateTestUseCase()) {
        self.testType = testType
        self.createTestUseCase = createTestUseCase
    }
    
    var isStartButtonEnabled: Bool {
        selectedPatient != nil && createdTest != nil 
    }
    
    var patientDisplayName: String {
        if let patient = selectedPatient {
            return "\(String(localized: "paciente", table: "ScaleMenu")): \(patient.name)"
        } else {
            return (String(localized: "scale.selectPatient", table: "ScaleMenu"))
        }
    }
    
    var patientName: String? {
        guard let patient = selectedPatient else { return nil }
        return String(patient.name.prefix(2).uppercased())
    }
    
    var hasSelectedPatient: Bool {
        selectedPatient != nil
    }
    
    func selectPatient(_ patient: Patient) {
        selectedPatient = patient
        showingPatientSelection = false
        
        Task {
            await createTestForSelectedPatient()
        }
    }
    
    func showPatientSelection() {
        showingPatientSelection = true
    }
    
    func dismissPatientSelection() {
        showingPatientSelection = false
    }
    
    //MARK: Create test
    @MainActor
    private func createTestForSelectedPatient() async {
        guard let patient = selectedPatient else { return }
    
        let test: ClinicalTestProtocol =  createTestUseCase.createTest(type: testType, patientID: patient.id, side: selectedSide)
        createdTest = test
    }

}
