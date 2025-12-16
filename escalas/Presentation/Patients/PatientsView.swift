//
//  PatientView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct PatientsView: View {
    @Environment(\.repositories) private var repositories
    
    @State var viewModel: PatientViewModel?
    
    @State private var showCreationForm = false
    @State private var newName = ""
    @State private var newDate = Date()
    @State private var isAdding = false
    
    var body: some View {
        NavigationStack {
            Group {
                if let viewModel = viewModel {
                    patientList(viewModel: viewModel)
                } else {
                    ProgressView("Cargando pacientes...")
                }
            }
            .navigationTitle("Pacientes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { isAdding.toggle() }
                    } label: {
                        Label("Añadir", systemImage: isAdding ? "xmark": "plus")
                    }
                }
            }
        }
            .task {
                let getUseCase = GetPatientUseCase(patientRepository: repositories.patientRepository)
                let createUseCase = CreatePatientUseCase(patientRepository: repositories.patientRepository)
                
                let vm = PatientViewModel(
                    getPatientsUseCase: getUseCase,
                    createPatientUseCase: createUseCase
                )
                
                viewModel = vm
                
                try? await viewModel?.loadPatients()
            }
        }
        
        @ViewBuilder
        func patientList(viewModel: PatientViewModel) -> some View {
            List {
                if isAdding {
                    Section {
                        TextField("Nombre del paciente", text: $newName)
                        
                        DatePicker("Fecha de nacimiento",
                                   selection: $newDate,
                                   displayedComponents: .date)
                        
                        Button("Crear paciente") {
                            Task {
                                try? await viewModel.createPatient(newName: newName, dateOfBirth: newDate)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } // isAdding
                ForEach(viewModel.patients, id: \.id) { patient in
                    VStack(alignment: .leading) {
                        Text(patient.name)
                            .font(.headline)
                        Text("Nacimiento: \(patient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            } // List
        }
    }

#Preview {
    PatientsView()
}
