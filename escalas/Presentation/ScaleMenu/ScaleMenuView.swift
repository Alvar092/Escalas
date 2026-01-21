//
//  ScaleView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct ScaleMenuView: View {
    
    @Environment(\.repositories) private var repositories
    
    @State private var viewModel: ScaleMenuViewModel
    let testType: TestType
    
    init(testType: TestType, createTestUseCase: CreateTestUseCaseProtocol = CreateTestUseCase()) {
        self.testType = testType
        self.viewModel = ScaleMenuViewModel(testType: testType, createTestUseCase: createTestUseCase)
    }
    

    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack (alignment: .center, spacing: 24) {
                    Text(viewModel.testType.displayName)
                        .font(.title.bold())
                        .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 12){
                        Button {
                            viewModel.showPatientSelection()
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(viewModel.hasSelectedPatient ? Color.accentColor.opacity(0.2): Color.gray.opacity(0.1))
                                        .frame(width: 32, height: 32)
                                    if let initials = viewModel.patientName {
                                        Text(initials)
                                            .font(.caption.bold())
                                            .foregroundColor(.accentColor)
                                    } else {
                                        Image(systemName: "person.fill")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                    }
                                }
                                
                                Text(viewModel.patientDisplayName)
                                    .foregroundStyle(.primary)
                                
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(Color.accentColor.gradient)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        NavigationLink {
                            ScaleInfoView(info: viewModel.testType.clinicalInfo)
                        } label: {
                            Text("Información de la prueba")
                                .frame(maxWidth: .infinity)
                                .padding(32)
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                        
                        NavigationLink {
                            if let test = viewModel.createdTest {
                                switch viewModel.testType {
                                case .berg:
                                    if let bergTest = test as? BergTest {
                                        BergTestView(viewModel: BergTestViewModel(useCase: SaveBergTestUseCase(repository: repositories.bergTestRepository), test: bergTest))
                                    }
                                }
                            }
                        } label: {
                            Text("Comenzar prueba")
                                .frame(maxWidth: .infinity)
                                .padding(48)
                                .background(
                                    viewModel.isStartButtonEnabled ?
                                    Color.accentColor.gradient: Color.gray.gradient
                                )
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                        .disabled(!viewModel.isStartButtonEnabled)
                    } // VStack
                    .padding(4.0)
                } // VStack nombre escala
            } // VStack general
        } // Nav Stack
        .sheet(isPresented: $viewModel.showingPatientSelection) {
            NavigationStack {
                PatientsView(mode:.select) { patient in
                    viewModel.selectPatient(patient)
                }
            }
        }
    }
}

#Preview {
    ScaleMenuView(testType: .berg)
}
