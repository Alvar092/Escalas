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
#if DEBUG
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
                    ),
                    deletePatientUseCase: DeletePatientUseCase(
                        patientsRepository: repositories.patientRepository
                    ),
                    editPatientUseCase: EditPatientUseCase(
                        patientsRepository: repositories.patientRepository
                    )
                )
            )
        } else {
            // Will never happen
            ProgressView("patients.loading")
        }
#else
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
                ),
                deletePatientUseCase: DeletePatientUseCase(
                    patientsRepository: repositories.patientRepository
                ),
                editPatientUseCase: EditPatientUseCase(
                    patientsRepository: repositories.patientRepository
                )
            )
        )
#endif
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
    @State private var patientToEdit: Patient? = nil
    
    var body: some View {
        patientList(viewModel: viewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.backg))
            .navigationTitle(mode == .select ? "patients.select.title" : "patients.browse.title")
            .toolbar {
                if mode == .select {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("patients.cancel") {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation { isAdding.toggle() }
                    } label: {
                        Label("patients.add", systemImage: isAdding ? "xmark" : "plus")
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
                    TextField("patients.name.placeholder", text: $newName)
                    
                    DatePicker("patients.birthdate.label",
                               selection: $newDate,
                               displayedComponents: .date)
                    
                    
                    Button("patients.create.button") {
                        Task {
                            try? await viewModel.createPatient(newName: newName, dateOfBirth: newDate)
                            try await viewModel.loadPatients()
                            isAdding = false
                            newName = ""
                            newDate = Date()
                        }
                    }
                    .padding()
                    .background(Color.prim)
                    .foregroundStyle(.textOnPrim)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
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
                                history: PatientHistory(patient: patient, bergTests: [], motricityIndexTests: [], trunkControlTests: []),
                                getTestsUseCase: GetPatientTestsUseCase(
                                    patientRepository: repositories.patientRepository,
                                    bergTestRepository: repositories.bergTestRepository,
                                    motricityIndexRepository: repositories.motricityIndexRepository,
                                    trunkControlTestRepository: repositories.trunkControlTestRepository
                                )
                            )
                        )
                    } label: {
                        patientRow(patient: patient)
                    }
                    .listRowBackground(Color.clear)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            Task {
                                try? await viewModel.deletePatient(id: patient.id)
                            }
                        } label: {
                            Label("Eliminar", systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            patientToEdit = patient
                        } label: {
                            Label("Editar", systemImage: "pencil")
                                .tint(.orange)
                        }
                    }
                    .sheet(item: $patientToEdit) { patient in
                        // Aquí reutilizas el mismo formulario inline que tienes para crear
                        // pero precargando los valores del paciente
                        EditPatientSheetView(patient: patient) { updatedPatient in
                            Task {
                                try? await viewModel.updatePatient(patient: patient)
                            }
                        }
                    }

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
                .foregroundStyle(.textOnPrim)
            Text("\(String(localized: "patients.age")) \(patient.age)")
                .font(.s)
                .foregroundStyle(.textOnPrim)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.prim))
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
    // Repository for preview
    let repositories = Repositories.preview
    
    // Calling view in browse mode
    PatientsView(
        mode: .select,
        onPatientSelected: nil
    )
    .environment(\.repositories, repositories)
}

struct EditPatientSheetView: View {
    
    let patient: Patient
    let onSave: (Patient) -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String
    @State private var dateOfBirth: Date
    
    init(patient: Patient, onSave: @escaping (Patient) -> Void) {
        self.patient = patient
        self.onSave = onSave
        _name = State(initialValue: patient.name)
        _dateOfBirth = State(initialValue: patient.dateOfBirth)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("patients.name.placeholder", text: $name)
                    
                    DatePicker("patients.birthdate.label",
                               selection: $dateOfBirth,
                               displayedComponents: .date)
                    
                    Button("patients.save.button") {
                        let updated = Patient(
                            id: patient.id,
                            name: name,
                            dateOfBirth: dateOfBirth
                        )
                        onSave(updated)
                        dismiss()
                    }
                    .padding()
                    .background(Color.prim)
                    .foregroundStyle(.textOnPrim)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(.backg))
            .navigationTitle("patients.edit.title")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("patients.cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
