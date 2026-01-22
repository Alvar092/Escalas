//
//  ScaleResultViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import Foundation
import Observation

@Observable
final class ScaleResultViewModel {
    
    var test: any ClinicalTestProtocol
    private(set) var patient: Patient?
    
    @ObservationIgnored
    private let useCase: GetPatientByIdUseCaseProtocol
    
    init(test: any ClinicalTestProtocol, useCase: GetPatientByIdUseCaseProtocol) {
        self.test = test
        self.useCase = useCase
    }
    
    func getPatient() async throws {
        if let user =  try await useCase.getPatient(by: test.patientID) {
            patient = user
        }
    }
}
