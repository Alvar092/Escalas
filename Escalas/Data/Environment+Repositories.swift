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
            BergTestEntity.self,
            MotricityIndexEntity.self
        ])
        return try! ModelContainer(for: schema)
    }()
    static let context = ModelContext(container)
}

private struct RepositoriesKey: EnvironmentKey {
    #if DEBUG
    static let defaultValue: Repositories? = nil
    #else
    static let defaultValue = Repositories(modelContext: DefaultModelContainer.context)
    #endif
}

extension EnvironmentValues{
#if DEBUG
    // En desarrollo: Opcional
    var repositories: Repositories? {
        get { self[RepositoriesKey.self] }
        set { self[RepositoriesKey.self] = newValue }
    }
#else
    // En producción: No opcional
    var repositories: Repositories {
        get { self[RepositoriesKey.self] }
        set { self[RepositoriesKey.self] = newValue }
    }
#endif
}

@Observable
class Repositories {
    let patientRepository: PatientRepositoryProtocol
    let bergTestRepository: BergTestRepositoryProtocol
    let motricityIndexRepository: MotricityIndexRepositoryProtocol
    let trunkControlTestRepository: TrunkControlTestRepositoryProtocol
    
    init(modelContext: ModelContext) {
        self.patientRepository = PatientRespository(modelContext: modelContext)
        self.bergTestRepository = BergTestRepository(modelContext: modelContext)
        self.motricityIndexRepository = MotricityIndexRepository(modelContext: modelContext)
        self.trunkControlTestRepository = TrunkControlTestRepository(modelContext: modelContext)
    }
    
    init(
        patientRepository: PatientRepositoryProtocol,
        bergTestRepository: BergTestRepositoryProtocol,
        motricityIndexRepository: MotricityIndexRepositoryProtocol,
        trunkControlTestRepository: TrunkControlTestRepositoryProtocol
    ) {
        self.patientRepository = patientRepository
        self.bergTestRepository = bergTestRepository
        self.motricityIndexRepository = motricityIndexRepository
        self.trunkControlTestRepository = trunkControlTestRepository
    }
}

//extension Repositories {
//    static var preview: Repositories {
//        let schema = Schema([
//            PatientEntity.self,
//            BergTestEntity.self,
//            MotricityIndexEntity.self,
//            TrunkControlEntity.self
//        ])
//        
//        let container = try! ModelContainer(for: schema, configurations: ModelConfiguration(isStoredInMemoryOnly: true)
//        )
//        return Repositories(modelContext: ModelContext(container))
//    }
//}

extension Repositories {
    static var preview: Repositories {
        Repositories(
            patientRepository: MockPatientRepository(initialPatients: [.patient1, .patient2, .patient3]),
            bergTestRepository: MockBergTestRepository(),
            motricityIndexRepository: MockMotricityIndexRepository(),
            trunkControlTestRepository: MockTrunkControlTestRepository()
        )
    }
}

