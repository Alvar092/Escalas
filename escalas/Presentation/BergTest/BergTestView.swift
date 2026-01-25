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
        VStack(spacing: 24) {
            
            VStack(alignment:.center, spacing: 8) {
                Text(viewModel.progress)
                    .font(.headline)
                
                HStack(alignment: .center) {
                    Text(viewModel.currentItemDefinition.title)
                        .font(.title2)
                        .bold()
                   
                }
                
                Text(viewModel.currentItemDefinition.description)
            } //VStack Pregunta y marcador
            
            if viewModel.currentItemDefinition.needsTimer {
                VStack {
                    Text(viewModel.formattedTime)
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                }
                
                HStack(spacing: 32) {
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
                
            } // Cronómetro
            
            Spacer()
            VStack {
                ForEach(viewModel.scoreOptions) { option in
                    Button {
                        viewModel.selectScore(option.score)
                    } label: {
                        HStack{
                            Text(option.description)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                        }
                        .padding(16)
                        
                        .background(                            RoundedRectangle(cornerRadius: 8)
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
            } //VStack Opciones respuestas
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Button{
                    viewModel.backItem()
                } label: {
                    Text("Atras")
                }
                
                Spacer()
                
                VStack{
                    Text("Puntuación\ntotal: \(viewModel.totalScore)/56")
                        .font(.headline)
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
            
        }//VStack padre
        .padding()
        .navigationDestination(isPresented: $viewModel.navigateToResultView) {
            ScaleResultView(viewModel: ScaleResultViewModel(test: viewModel.test, useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)))
        }
    }
}


#Preview {
    let mockRepository = MockBergTestRepository()
    
    BergTestView(viewModel: BergTestViewModel(
        useCase: SaveBergTestUseCase(repository: mockRepository),
        test: BergTest.patient1))
}
