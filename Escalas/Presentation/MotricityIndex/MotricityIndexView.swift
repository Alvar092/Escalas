//
//  MotorIndexView.swift
//  Escalas
//
//  Created by Álvaro Entrena Casas on 6/2/26.
//

import SwiftUI

struct MotricityIndexView: View {
    
    @Environment(\.repositories) private var repositories
    
    let viewModel: MotricityIndexViewModel
    @State private var showingSideSelection = false
    
    var body: some View {
        #if DEBUG
        if let repositories {
            MotricityIndexContentView(repositories: repositories, viewModel: viewModel)
                .sheet(isPresented: $showingSideSelection) {
                    SideSelectionView { selectedSide in
                        viewModel.test.side = selectedSide
                        viewModel.isSideSelected = true
                        showingSideSelection = false
                    }
                    .interactiveDismissDisabled(true)
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
                }
            
                .onAppear {
                    if viewModel.test.side == nil || !viewModel.isSideSelected {
                        showingSideSelection = true
                    }
                }
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

private struct MotricityIndexContentView: View {
    let repositories: Repositories
    
    @Environment(\.navigationRouter) private var router
    @State var viewModel: MotricityIndexViewModel
    
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.progress)
                            .font(.mSemi)
                        
                        Text(viewModel.currentItemDefinition.title)
                            .font(.lSemi)
                        
                        Text(viewModel.currentItemDefinition.description)
                            .font(.m)
                    } // VStack Item
                    
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.scoreOptions) { option in
                            optionButton(for: option)
                        }
                    } //VStack buttons
                    .navigationDestination(isPresented: $viewModel.navigateToResultView) {
                        ScaleResultView(
                            viewModel: ScaleResultViewModel(
                                test: viewModel.test,
                                useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)
                            )
                        )
                    }
                } // VStack gen.
                .padding(.horizontal, 24)
            } //SrollView
        }//ZStack
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
        .background(Color.backg)
    }
    
    @ViewBuilder
    private func optionButton(for option: MotricityScoreOption) -> some View {
        Button {
            viewModel.selectScore(option.score)
        } label: {
            HStack(alignment: .top) {
                Text(option.description)
                    .foregroundStyle(Color.prim)
                    .font(.m)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColorForOption(option))
            )
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(strokeColorForOption(option))
            )
        }
    }
    
    private func backgroundColorForOption(_ option: MotricityScoreOption) -> Color {
        viewModel.isOptionSelected(option) ? Color(.sec) : Color.clear
    }
    
    private func strokeColorForOption(_ option: MotricityScoreOption) -> Color {
           viewModel.isOptionSelected(option) ? Color.blue : Color.blue.opacity(0.7)
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
            
            VStack(alignment: .center, spacing: 4) {
                Text("Puntuación MS: \(viewModel.upperLimbScore)/100")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Text("Puntuación MI: \(viewModel.lowerLimbScore)/100")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button(viewModel.isLastItem ? "Finalizar" : "Siguiente") {
                if viewModel.isLastItem {
                    Task {
                        try? await viewModel.finishTest()
                        let completedTest = viewModel.test
                        router.navigateToResults(testType: .motricityIndex, completedTest: completedTest)
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
    } // BottomBar
} //MotricityIndexContentView

struct SideSelectionView: View {
    let onSelect: (BodySide) -> Void
    
    var body: some View {
        VStack {
            Text("Selecciona el lado a evaluar")
                .font(.lSemi)
                .multilineTextAlignment(.center)
            
            HStack {
                Button {
                    onSelect(.left)
                } label: {
                    Text("Izquierdo")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color(.prim))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.mSemi)
                }
                
                Button {
                    onSelect(.right)
                } label: {
                    Text("Derecho")
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color(.prim))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.mSemi)
                }
            }
            .padding()
        }
        .padding(24)
    }
 }

#Preview {
    let router = NavigationRouter()
    let repositories = Repositories.preview
    
    let test = MotricityIndex.patient1
    router.currentTest = test
    
    return NavigationStack(path: .constant(NavigationPath())) {
            router.makeTestView(for: .motricityIndex, repositories: repositories)
        }
        .environment(\.navigationRouter, router)
        .environment(\.repositories, repositories)
}
