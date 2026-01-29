//
//  ScaleResultView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 22/1/26.
//

import SwiftUI

struct ScaleResultView: View {
    
    @Environment(\.navigationRouter) private var router
    @State var viewModel: ScaleResultViewModel
    
    
    var body: some View {
        VStack(spacing: 20) {
            // Título test
            Text(viewModel.test.name)
                .font(.title)
                .bold()
            VStack(alignment: .leading,spacing: 12){
                // Paciente seleccionado
                if let patient = viewModel.patient {
                    Text("Paciente:\(patient.name)")
                }
                
                Text("Fecha: \(formatDate(viewModel.test.date))")
                    
                
                
                // Puntuación
                if let maxScore = viewModel.test.maxScore {
                    Text("Puntuación: \(viewModel.test.totalScore) / \(maxScore)")
                        .font(.largeTitle)
                } else {
                    Text("Puntuación: \(viewModel.test.totalScore)")
                }
                
                // Exportar en PDF
                Button {
                    viewModel.exportPDF()
                } label: {
                    Label("Exportar en PDF", systemImage: "doc.text.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            
            
        }
        
        Spacer()
        
        VStack{
            Button {
                router.navigateToRoot()
            } label: {
                Label("Volver a inicio", systemImage: "house.fill")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(12)
        }
        .padding(.horizontal)
        
        
        .sheet(isPresented: $viewModel.showShare) {
            if let url = viewModel.pdfURL {
                ShareSheet(items: [url])
            }
        }
        
        .alert("Información", isPresented: $viewModel.showError) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text(viewModel.errorText)
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
    
    private func formatDate(_ date: Date) -> String {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          formatter.locale = Locale(identifier: "es_ES")
          return formatter.string(from: date)
      }
    
    struct ShareSheet: UIViewControllerRepresentable {
        let items: [Any]
        
        func makeUIViewController(context: Context) -> UIActivityViewController {
            UIActivityViewController(activityItems: items, applicationActivities: nil)
        }
        
        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    }
}

#Preview {
    let mockRepo = MockPatientRepository(initialPatients: [Patient.patient1])
    
    ScaleResultView(viewModel: ScaleResultViewModel(test: BergTest.patient1, useCase: GetPatientByIdUseCase(patientsRepository: mockRepo)))
}
