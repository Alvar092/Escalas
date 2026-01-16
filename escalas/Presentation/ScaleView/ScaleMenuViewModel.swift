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
    var showingPatientSelection = false
    let testType: TestType
    
    init(testType: TestType) {
        self.testType = testType
    }
    
    var isStartButtonEnabled: Bool {
        selectedPatient != nil
    }
    
    var patientDisplayName: String {
        selectedPatient?.name ?? "Seleccionar paciente"
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
    }
    
    func showPatientSelection() {
        showingPatientSelection = true
    }
    
    func dismissPatientSelection() {
        showingPatientSelection = false
    }
    
    
}
