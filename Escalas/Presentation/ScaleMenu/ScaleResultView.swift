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
        ZStack {
            Color.backg
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text(viewModel.test.name)
                    .font(.xlSemi)
                    .bold()
                
                VStack(alignment: .leading, spacing: 12) {
                    if let patient = viewModel.patient {
                        Text(String(format: String(localized: "scale.result.patient", table: "ScaleMenu"), patient.name))
                            .font(.l)
                    }
                    
                    Text(String(format: String(localized: "testDetailDate"), formatDate(viewModel.test.date)))
                        .font(.l)
                    
                    if let sidedTest = viewModel.test as? SideTestProtocol,
                       let side = sidedTest.side {
                        Text(String(format: String(localized: "testDetail.side"), side.rawValue.capitalized))
                            .font(.l)
                    }
                    
                    if let maxScore = viewModel.test.maxScore {
                        Text(String(format: String(localized: "scale.result.score.withMax", table: "ScaleMenu"), viewModel.test.totalScore, maxScore))
                            .font(.l)
                    } else {
                        Text(String(format: String(localized: "scale.result.score.withoutMax", table: "ScaleMenu"), viewModel.test.totalScore))
                            .font(.l)
                    }
                    
                    Button {
                        viewModel.exportPDF()
                    } label: {
                        Label(String(localized: "testDetail.exportPDF"), systemImage: "doc.text.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.prim))
                            .foregroundStyle(.textOnPrim)
                            .font(.m)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .background(Color.backg)
        
        VStack {
            Button {
                router.navigateToRoot()
            } label: {
                Label(String(localized: "scale.result.backToHome", table: "ScaleMenu"), systemImage: "house.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.prim))
                    .font(.m)
                    .foregroundStyle(.textOnPrim)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal)
        
        .sheet(isPresented: $viewModel.showShare) {
            if let url = viewModel.pdfURL {
                ShareSheet(items: [url])
            }
        }
        
        .alert(String(localized: "scale.result.alert.title", table: "ScaleMenu"), isPresented: $viewModel.showError) {
            Button(String(localized: "scale.result.alert.ok", table: "ScaleMenu"), role: .cancel) {}
        } message: {
            Text(viewModel.errorText)
        }
        
        .task {
            do {
                try await viewModel.getPatient()
            } catch {
                print("Error cargando paciente: \(error)")
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
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
