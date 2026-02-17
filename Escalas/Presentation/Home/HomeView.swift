//
//  HomeView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

enum HomeRoute: Hashable {
    case patients
}

import SwiftUI

struct HomeView: View {
    
    
    @Environment(\.repositories) private var repositories
    @State private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .center, spacing: 32) {
                // Sección superior: mensaje de bienvenida + icono de perfil
                VStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .center, spacing: 4) {
                        Text("¡Bienvenido!")
                            .font(.xlSemi)
                        Text("Nos alegra verte de nuevo.")
                            .font(.m)
                            
                    }
                    ZStack {
                        Circle()
                            .fill(Color(.prim))
                            .frame(width: 48, height: 48)
                        
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .background(Color(.prim))
                            .frame(width: 32, height: 32)
                    } // ZStack
                } // VStack Bienvenida
                VStack(alignment: .center, spacing: 20) {
                    Text("Elige una escala para comenzar")
                        .font(.m)
                        .foregroundStyle(.textPrim)
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            router.navigate(to: .scaleMenu(testType: .berg))
                        } label: {
                            Text("Berg Test")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.prim))
                                .foregroundStyle(.textOnPrim)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                       
                        Button {
                            router.navigate(to: .scaleMenu(testType: .motricityIndex)) 
                            
                        } label: {
                            Text("Motricity Index")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.prim))
                                .foregroundStyle(.textOnPrim)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        Button {
                             router.navigate(to: .scaleMenu(testType: .trunkControlTest))
                        } label: {
                            Text("Trunk Control Test")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.prim))
                                .foregroundStyle(.textOnPrim)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        Button {
                            /* router.navigate(to: .scaleMenu(testType: .10mwt)) */
                        } label: {
                            Text("Próximamente")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .disabled(true)
                        
                        
                    } //VStack Escalas
                } // VStack Elige escalas
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Button("Pacientes") {
                                router.navigate(to: .patients(mode: .browse))
                            }
                            
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .imageScale(.large)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .background(Color(.backg))
            .navigationDestination(for: AppRoute.self) { route in
                routeView(for: route)
            }
        }
        .environment(\.navigationRouter, router)
    } // View
        
    
    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
        if let repositories {
            
            switch route {
            case .scaleMenu(let testType):
                ScaleMenuView(testType: testType)
                
            case .test(let testType):
                router.makeTestView(for: testType, repositories: repositories)
                
            case .scaleResult(let testType):
                router.makeResultView(for: testType, repositories: repositories)
                
            case .patients:
                PatientsView(mode: .browse)
            }
        }
        else {
            ContentUnavailableView(
                       "Error de configuración",
                       systemImage: "exclamationmark.triangle",
                       description: Text("Los repositorios no están disponibles")
                   )
        }
    }
}

#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environment(\.repositories, Repositories.preview)
}
