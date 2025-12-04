//
//  Environment+Repositories.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//
import SwiftUI
import SwiftData

// MARK: -Default SwifData Container (just for fallback)
// el default value no puede ser nil y no puedo inicializar ModelContext vacio
private enum DefaultModelContainer {
    static let container: ModelContainer = {
        let schema = Schema([
            PatientEntity.self,
            BergTestEntity.self
        ])
        return try! ModelContainer(for: schema)
    }()
    static let context = ModelContext(container)
}

private struct RepositoriesKey: EnvironmentKey {
    static let defaultValue = Repositories(modelContext: DefaultModelContainer.context)
}

extension EnvironmentValues{
    var repositories: Repositories {
        get {self[RepositoriesKey.self]}
        set {self[RepositoriesKey.self] = newValue }
    }
}

@Observable
class Repositories {
    let patientRepository: PatientRepositoryProtocol
    let bergTestRepository: BergTestRepositoryProtocol
    
    init(modelContext: ModelContext) {
        self.patientRepository = PatientRespository(modelContext: modelContext)
        self.bergTestRepository = BergTestRepository(modelContext: modelContext)
    }
}


