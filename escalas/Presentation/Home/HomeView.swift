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
                            .font(.title.bold())
                        Text("Nos alegra verte de nuevo.")
                            .foregroundStyle(.secondary)
                    }
                    ZStack {
                        Circle()
                            .fill(Color.blue.gradient)
                            .frame(width: 48, height: 48)
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                    } // ZStack
                } // VStack Bienvenida
                VStack(alignment: .center, spacing: 20) {
                    Text("Elige una escala para comenzar")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        Button("Berg Test") {
                            router.navigate(to: .scaleMenu(testType: .berg)) //ScaleMenuView(testType: .berg)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        
                        
                        Button("Time Up & Go") {
                            /* goToTUG */
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        
                        Button("10 Metres Walking Test") {
                            /* GoTo10MWT */
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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
            .navigationDestination(for: AppRoute.self) { route in
                routeView(for: route)
            }
        }
        .environment(\.navigationRouter, router)
    }
    
    @ViewBuilder
    private func routeView(for route: AppRoute) -> some View {
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
}

#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environment(\.repositories, Repositories.preview)
}
