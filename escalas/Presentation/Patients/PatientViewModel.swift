//
//  PatientViewModel.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import Foundation
 

@Observable
final class PatientViewModel {
    // Publishers
    var patients = [Patient]()
    
    @ObservationIgnored
    private var useCase: PatientUseCaseProtocol
    
    init(useCase: PatientUseCaseProtocol) {
        self.useCase = useCase
        
        Task {
            await self.getPatients()
        }
    }
    
    @MainActor
    func getPatients() async {
        do {
            patients = try await useCase.getPatients()
        } catch {
            print("Error loading patients: \(error)")
        }
    }
}
