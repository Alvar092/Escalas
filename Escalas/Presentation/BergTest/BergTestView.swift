//
//  BergTestFormView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 4/12/25.
//

import SwiftUI

struct BergTestView: View {
    @Environment(\.repositories) private var repositories
    
    let viewModel: BergTestViewModel
    
    var body: some View {
        #if DEBUG
        if let repositories {
            BergTestContentView(
                repositories: repositories,
                viewModel: viewModel
            )
        } else {
            ContentUnavailableView(
                "Error de configuración",
                systemImage: "exclamationmark.triangle",
                description: Text("Repositories no disponibles")
            )
        }
        #else
        BergTestContentView(
            repositories: repositories,
            viewModel: viewModel
        )
        #endif
    }
}

private struct BergTestContentView: View {
    let repositories: Repositories
    
    @Environment(\.navigationRouter) private var router
    @State var viewModel: BergTestViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.progress)
                            .font(.headline)
                        
                        Text(viewModel.currentItemDefinition.title)
                            .font(.title2)
                            .bold()
                        
                        Text(viewModel.currentItemDefinition.description)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if viewModel.currentItemDefinition.needsTimer {
                        HStack(spacing: 16) {
                            Text(viewModel.formattedTime)
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                            
                            Spacer()
                            
                            Button(viewModel.isTimerRunning ? "Pausar" : "Iniciar") {
                                if viewModel.isTimerRunning {
                                    viewModel.stopTimer()
                                } else {
                                    viewModel.startTimer()
                                }
                            }
                            .foregroundStyle(Color(.prim))
                            
                            Button("Reset") {
                                viewModel.resetTimer()
                            }
                            .foregroundStyle(Color(.prim))
                        }
                        .padding(.horizontal, 32)
                    }
                    
                    VStack(spacing: 12) {
                        ForEach(viewModel.scoreOptions) { option in
                            Button {
                                viewModel.selectScore(option.score)
                            } label: {
                                Text(option.description)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(fontColorForOption(option))
                                    .font(.m)
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 16)
                                    .background(backgroundColorForOption(option))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(strokeColorForOption(option))
                                    )
                                    .contentShape(Rectangle())
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            .background(Color.backg)
            .safeAreaInset(edge: .bottom) {
                bottomBar
            }
    }
        .navigationDestination(isPresented: $viewModel.navigateToResultView) {
            // ✅ Ya no necesitas unwrap
            ScaleResultView(
                viewModel: ScaleResultViewModel(
                    test: viewModel.test,
                    useCase: GetPatientByIdUseCase(
                        patientsRepository: repositories.patientRepository
                    )
                )
            )
        }
    }
    
    private func backgroundColorForOption(_ option: BergScoreOption) -> Color {
        viewModel.isOptionSelected(option) ? Color(.sec) : Color.clear
    }
    
    private func strokeColorForOption(_ option: BergScoreOption) -> Color {
           viewModel.isOptionSelected(option) ? Color.blue : Color.blue.opacity(0.7)
       }
    
    private func fontColorForOption(_ option: BergScoreOption) -> Color {
        viewModel.isOptionSelected(option) ? Color.textSecondary : Color.textPrim
    }
    
    private var bottomBar: some View {
        HStack(alignment: .bottom) {
            Button {
                viewModel.backItem()
            } label: {
                Text("Atras")
                    .font(.mSemi)
                    .foregroundStyle(Color(.prim))
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("Puntuación\ntotal: \(viewModel.totalScore)/56")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button(viewModel.isLastItem ? "Finalizar" : "Siguiente") {
                if viewModel.isLastItem {
                    Task {
                        try? await viewModel.finishTest()
                        let completedTest = viewModel.test
                        router.navigateToResults(testType: .berg, completedTest: completedTest)
                    }
                } else {
                    viewModel.nextItem()
                }
            }
            .font(.mSemi)
            .foregroundStyle(Color(.prim))
        }
        .padding()
        .background(Color.backg)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    let router = NavigationRouter()
    let repositories = Repositories.preview
    
    let test = BergTest.patient1
    router.currentTest = test
    
    return NavigationStack(path: .constant(NavigationPath())) {
            router.makeTestView(for: .berg, repositories: repositories)
        }
        .environment(\.navigationRouter, router)
        .environment(\.repositories, repositories)
}

