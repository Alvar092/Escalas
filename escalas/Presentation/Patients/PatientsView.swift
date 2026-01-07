//
//  PatientView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

enum PatientSelectionMode {
    case browse
    case select
}

struct PatientsView: View {
    
    let mode: PatientSelectionMode
    var onPatientSelected: ((Patient) -> Void)? = nil
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.repositories) private var repositories
    
    @State private var viewModel: PatientViewModel?
    
    @State private var showCreationForm = false
    @State private var newName = ""
    @State private var newDate = Date()
    @State private var isAdding = false
    
    
    var body: some View {
        NavigationStack {
            Group {
                if let viewModel {
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
                            try await viewModel.loadPatients()
                            isAdding = false
                            newName = ""
                            newDate = Date()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } // isAdding
            ForEach(viewModel.patients, id: \.id) { patient in
                Button(action: {
                    handlePatientTap(patient)
                }) {
                    VStack(alignment: .leading) {
                        Text(patient.name)
                            .font(.headline)
                        Text("Nacimiento: \(patient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
            }
        } // List
    }
    private func handlePatientTap(_ patient: Patient) {
        if mode == .select {
            onPatientSelected?(patient)
            dismiss()
        } else {
            // NAVEGAR AL DETALLE DEL PACIENTE
        }
    }
}

#Preview {
    @Previewable @State var selectedPatient: Patient? = nil
    PatientsView(mode: .browse)
}
