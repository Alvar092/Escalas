//
//  escalasApp.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 30/11/25.
//

import SwiftUI
import SwiftData

@main
struct EscalasApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PatientEntity.self,
            BergTestEntity.self
        ])
        
        let configuration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.repositories, Repositories(modelContext: ModelContext(sharedModelContainer)))
        }
        .modelContainer(sharedModelContainer)
    }}
