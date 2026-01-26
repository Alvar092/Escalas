//
//  BergTestFormView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import SwiftUI

struct BergTestView: View {
    
    @Environment(\.repositories) private var repositories
    @State var viewModel: BergTestViewModel
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment:.leading, spacing: 16) {
                        Text(viewModel.progress)
                            .font(.headline)
                        
                        Text(viewModel.currentItemDefinition.title)
                            .font(.title2)
                            .bold()
                        
                        Text(viewModel.currentItemDefinition.description)
                            .multilineTextAlignment(.leading)
                    } //VStack Pregunta y marcador
                    
                    
                    if viewModel.currentItemDefinition.needsTimer {
                        HStack(spacing: 16) {
                            Text(viewModel.formattedTime)
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                            
                            Spacer()
                            
                            Button(viewModel.isTimerRunning ? "Pausar" : "Iniciar"){
                                if viewModel.isTimerRunning {
                                    viewModel.stopTimer()
                                } else {
                                    viewModel.startTimer()
                                }
                            }
                            Button("Reset") {
                                viewModel.resetTimer()
                            }
                        }
                        .padding(.horizontal, 32)
                    } // Cronómetro
                    
                    VStack(spacing: 12) {
                        ForEach(viewModel.scoreOptions) { option in
                            Button {
                                viewModel.selectScore(option.score)
                            } label: {
                                HStack(alignment: .top){
                                    Text(option.description)
                                        .foregroundStyle(.primary)
                                        .font(.subheadline)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(
                                        viewModel.isOptionSelected(option)
                                        ? Color.accentColor.opacity(0.2) : Color.clear
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(
                                            viewModel.isOptionSelected(option)
                                            ? Color.blue
                                            : Color.blue.opacity(0.7)
                                        )
                                )
                            }
                        }
                        .buttonStyle(.plain)
                    } //VStack Opciones respuestas
                }//VStack padre
                .padding()
                .padding(.bottom, 100)
            }
            bottomBar
        }
        .navigationDestination(isPresented: $viewModel.navigateToResultView) {
            ScaleResultView(viewModel: ScaleResultViewModel(test: viewModel.test, useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)))
        }
    }
    
    private var bottomBar: some View {
        HStack(alignment: .bottom) {
            Button{
                viewModel.backItem()
            } label: {
                Text("Atras")
            }
            
            Spacer()
            
            VStack(alignment: .center){
                Text("Puntuación\ntotal: \(viewModel.totalScore)/56")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            Button(viewModel.isLastItem ? "Finalizar" : "Siguiente") {
                if viewModel.isLastItem {
                    Task {
                        try? await viewModel.finishTest()
                    }
                } else {
                    viewModel.nextItem()
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .ignoresSafeArea(edges: .bottom)
    }
    
    
    
}

#Preview {
    let mockRepository = MockBergTestRepository()
    
    BergTestView(viewModel: BergTestViewModel(
        useCase: SaveBergTestUseCase(repository: mockRepository),
        test: BergTest.patient1))
}

