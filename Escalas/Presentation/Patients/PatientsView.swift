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
    
    var body: some View {
        if let repositories {
            PatientsContentView(
                mode: mode,
                onPatientSelected: onPatientSelected,
                repositories: repositories,
                viewModel: PatientViewModel(
                    getPatientsUseCase: GetPatientsUseCase(
                        patientRepository: repositories.patientRepository
                    ),
                    createPatientUseCase: CreatePatientUseCase(
                        patientRepository: repositories.patientRepository
                    )
                )
            )
        } else {
            // Teoricamente esto nunca pasará
            ProgressView("Inicializando...")
        }
    }
}


private struct PatientsContentView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    
    let mode: PatientSelectionMode
    var onPatientSelected: ((Patient) -> Void)? = nil
    let repositories: Repositories
    
    @State var viewModel: PatientViewModel
    
    @State private var showCreationForm = false
    @State private var newName = ""
    @State private var newDate = Date()
    @State private var isAdding = false
    
    var body: some View {
        patientList(viewModel: viewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.backg))
            .navigationTitle(mode == .select ? "Seleccionar paciente" : "Pacientes")
            .toolbar {
                if mode == .select {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancelar") {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { isAdding.toggle() }
                    } label: {
                        Label("Añadir", systemImage: isAdding ? "xmark" : "plus")
                    }
                }
            }
            .task {
                try? await viewModel.loadPatients()
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
                if mode == .select {
                    Button(action: {
                        handlePatientTap(patient)
                    }) {
                        patientRow(patient: patient)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.clear)
                } else {
                    NavigationLink{
                        PatientDetailView(
                            viewModel: PatientDetailViewModel(
                                patient: patient,
                                history: PatientHistory(patient: patient, bergTests: []),
                                getTestsUseCase: GetPatientTestsUseCase(
                                    patientRepository: repositories.patientRepository,
                                    bergTestRepository: repositories.bergTestRepository
                                )
                            )
                        )
                    } label: {
                        patientRow(patient: patient)
                    }
                    .listRowBackground(Color.clear)
                }
            }
        } // List
        .scrollContentBackground(.hidden)
        .background(Color(.backg))
    }
    
    @ViewBuilder
    private func patientRow(patient: Patient) -> some View {
        VStack(alignment: .leading) {
            Text(patient.name)
                .font(.m)
                .foregroundStyle(.textOnPrimary)
            Text("Nacimiento: \(patient.dateOfBirth.formatted(date: .abbreviated, time: .omitted))")
                .font(.s)
                .foregroundStyle(.textOnPrimary)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.primary))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
    
    private func handlePatientTap(_ patient: Patient) {
        if mode == .select {
            onPatientSelected?(patient)
            dismiss()
        } else {
            
        }
    }
}

#Preview {
    @Previewable @State var selectedPatient: Patient? = nil
    PatientsView(mode: .browse)
}
