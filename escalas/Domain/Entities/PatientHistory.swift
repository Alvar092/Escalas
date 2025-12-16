//
//  PatientHistory.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import Foundation

struct PatientHistory {
    let patient: Patient
    
    let bergTests: [BergTest]
    
    var allTests: [any ClinicalTestProtocol] {
        
        var all: [any ClinicalTestProtocol] = []
        all.append(contentsOf: bergTests)
        
        return all.sorted { $0.date > $1.date }
    }
}
