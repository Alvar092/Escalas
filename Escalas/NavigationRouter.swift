//
//  NavigationRouter.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 28/1/26.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable {
    case scaleMenu(testType: TestType)
    case test(testType: TestType)
    case scaleResult(testType:TestType)
    case patients(mode: PatientSelectionMode)
}

@Observable
final class NavigationRouter {
    var path = NavigationPath()
    var currentTest: ClinicalTestProtocol?
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func navigateToTest(testType: TestType, test: any ClinicalTestProtocol) {
        self.currentTest = test
        path.append(AppRoute.test(testType: testType))
    }
    
    func navigateToResults(testType: TestType, completedTest: any ClinicalTestProtocol) {
        self.currentTest = completedTest
        path.append(AppRoute.scaleResult(testType: testType))
    }
    
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func navigateToRoot() {
        path = NavigationPath()
    }
    
    func pop(count: Int) {
        let itemsToPop = min(count, path.count)
        path.removeLast(itemsToPop)
    }
}

private struct NavigationRouterKey: EnvironmentKey {
    static let defaultValue = NavigationRouter()
}

extension EnvironmentValues{
    var navigationRouter: NavigationRouter {
        get { self[NavigationRouterKey.self] }
        set { self[NavigationRouterKey.self] = newValue }
    }
}

extension NavigationRouter {
    @ViewBuilder
    func makeTestView(for testType: TestType, repositories: Repositories) -> some View {
        if let test = currentTest {
            
            switch testType {
            case .berg:
                if let bergTest = test as? BergTest {
                    BergTestView(
                        viewModel: BergTestViewModel(
                            useCase: SaveBergTestUseCase(repository: repositories.bergTestRepository),
                            test: bergTest
                        )
                    )
                }
            case .motricityIndex:
                if let motricityTest = test as? MotricityIndex {
                    MotricityIndexView(
                        viewModel: MotricityIndexViewModel(
                            useCase: SaveMotricityIndexUseCase(repository: repositories.motricityIndexRepository),
                            test: motricityTest
                        )
                    )
                }
                
            case .trunkControlTest:
                if let trunkControlTest = test as? TrunkControlTest {
                    TrunkControlTestView(
                        viewModel: TrunkControlTestViewModel(
                            useCase: SaveTrunkControlTestUseCase(repository: repositories.trunkControlTestRepository),
                            test: trunkControlTest
                        )
                    )
                }
            }
        } else {
            ContentUnavailableView(
                "Error al cargar el test",
                systemImage: "exclamationmark.triangle",
                description: Text("No se pudo inicializar el test correctamente")
            )
        }
    }
}

extension NavigationRouter {
    @ViewBuilder
    func makeResultView(for testType: TestType, repositories: Repositories) -> some View {
        if let test = currentTest {
            switch testType {
            case .berg:
                if let bergTest = test as? BergTest {
                    ScaleResultView(
                        viewModel: ScaleResultViewModel(
                            test: bergTest,
                            useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)
                        )
                    )
                }
                
            case .motricityIndex:
                if let motricityTest = test as? MotricityIndex {
                    ScaleResultView(
                        viewModel: ScaleResultViewModel(
                            test: motricityTest,
                            useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)
                        )
                    )
                }
                
            case .trunkControlTest:
                if let trunkTest = test as? TrunkControlTest {
                    ScaleResultView(
                        viewModel: ScaleResultViewModel(
                            test: trunkTest,
                            useCase: GetPatientByIdUseCase(patientsRepository: repositories.patientRepository)
                        )
                    )
                }
                
                
            }//Switch
        }
    }
}


