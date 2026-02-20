//
//  ScaleView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct ScaleMenuView: View {
    
    @Environment(\.repositories) private var repositories
    @Environment(\.navigationRouter) private var router
    
    @State private var viewModel: ScaleMenuViewModel
    let testType: TestType
    
    init(testType: TestType, createTestUseCase: CreateTestUseCaseProtocol = CreateTestUseCase()) {
        self.testType = testType
        self.viewModel = ScaleMenuViewModel(testType: testType, createTestUseCase: createTestUseCase)
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 24) {
                Text(viewModel.testType.displayName)
                    .font(.xlSemi)
                    .padding()
                
                Spacer()
                
                VStack(alignment: .center, spacing: 12) {
                    Button {
                        viewModel.showPatientSelection()
                    } label: {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(patientButtonBackgroundColor())
                                    .frame(width: 32, height: 32)
                                patientInitialsOrIcon()
                            }
                            
                            Text(viewModel.patientDisplayName)
                                .foregroundStyle(.textOnPrim)
                            
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                        .background(Color(.prim))
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    
                    NavigationLink {
                        ScaleInfoView(info: viewModel.testType.clinicalInfo)
                    } label: {
                        Text(String(localized: "scale.menu.testInfo", table: "ScaleMenu"))
                            .frame(maxWidth: .infinity)
                            .padding(32)
                            .background(Color(.prim))
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    
                    Button {
                        if let test = viewModel.createdTest {
                            router.navigateToTest(testType: testType, test: test)
                        }
                    } label: {
                        Text(String(localized: "scale.menu.start", table: "ScaleMenu"))
                            .frame(maxWidth: .infinity)
                            .padding(48)
                            .background(startButtonBackgroundColor())
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .disabled(!viewModel.isStartButtonEnabled)
                }
            }
            .padding(4.0)
        }
        .sheet(isPresented: $viewModel.showingPatientSelection) {
            NavigationStack {
                PatientsView(mode: .select) { patient in
                    viewModel.selectPatient(patient)
                }
            }
        }
        .background(Color(.backg))
    }
}

private extension ScaleMenuView {
    func patientButtonBackgroundColor() -> Color {
        viewModel.hasSelectedPatient ? Color.accentColor.opacity(0.2) : Color.gray.opacity(0.1)
    }
    
    func startButtonBackgroundColor() -> Color {
        viewModel.isStartButtonEnabled ? Color(.prim) : Color.gray
    }
    
    @ViewBuilder
    func patientInitialsOrIcon() -> some View {
        if let initials = viewModel.patientName {
            Text(initials)
                .font(.m)
                .foregroundColor(.textOnPrim)
        } else {
            Image(systemName: "person.fill")
                .font(.title)
                .foregroundStyle(.textOnPrim)
        }
    }
}

#Preview {
    @Previewable @State var router = NavigationRouter()
    let repositories = Repositories.preview
    
    NavigationStack(path: $router.path) {
        ScaleMenuView(testType: .motricityIndex)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .test(let testType):
                    router.makeTestView(for: testType, repositories: repositories)
                default:
                    Text("otra vista")
                }
            }
    }
    .environment(\.navigationRouter, router)
    .environment(\.repositories, repositories)
}
