//
//  PatientView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct PatientView: View {
    @Environment(\.repositories) private var repositories
    
    //@State var patients: [Patient]
    
    @State var viewModel: PatientViewModel
    
    init(repositories: Repositories?) {
        let repo: PatientRepositoryProtocol? = repositories?.patientRepository
        let useCase = PatientUseCase(patientRepository: repo)
        self._viewModel = State(wrappedValue: PatientViewModel(useCase: useCase))
    }
    

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.patients, id: \.id) { patient in
                    VStack(alignment: .leading) {
                        Text(patient.name)
                            .font(.headline)
                        Text("Nacimiento: \(patient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Pacientes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Acción para añadir nuevo paciente
                    }) {
                        Label("Añadir", systemImage: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    PatientView(repositories: nil)
}
