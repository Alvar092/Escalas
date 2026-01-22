//
//  ScaleResultView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import SwiftUI

struct ScaleResultView: View {
    @State var viewModel: ScaleResultViewModel
    
    var body: some View {
        VStack {
            // Paciente seleccionado
            if let patient = viewModel.patient {
                Text("Paciente:\(patient.name)")
            }
            // Título test
            Text(viewModel.test.name)
                .font(.title)
            
            // Puntuación
            if let maxScore = viewModel.test.maxScore {
                Text("\(viewModel.test.totalScore) / \(maxScore)")
                    .font(.largeTitle)
            } else {
                Text("\(viewModel.test.totalScore)")
            }
            // Exportar en PDF
            Button("Exportar en PDF") {
                // CreatePDF()
            }
        }
        .task {
            do {
                try await viewModel.getPatient()
            }
            catch {
                print("Error cargando paciente: \(error)")
            }
        }
    }
}

#Preview {
    let mockRepo = MockPatientRepository(initialPatients: [Patient.patient1])
    
    ScaleResultView(viewModel: ScaleResultViewModel(test: BergTest.patient1, useCase: GetPatientByIdUseCase(patientsRepository: mockRepo)))
}
