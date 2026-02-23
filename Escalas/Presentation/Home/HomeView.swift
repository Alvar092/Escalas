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
                // Welcome message
                VStack(alignment: .center, spacing: 16) {
                    VStack(alignment: .center, spacing: 4) {
                        Text("home.welcome")
                            .font(.xlSemi)
                        Text("home.welcome.subtitle")
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
                } // VStack Welcome
                VStack(alignment: .center, spacing: 20) {
                    Text("home.select.scale")
                        .font(.m)
                        .foregroundStyle(.textPrim)
                    
                    VStack(spacing: 12) {
                        
                        Button {
                            router.navigate(to: .scaleMenu(testType: .berg))
                        } label: {
                            Text("home.scale.berg")
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
                            Text("home.scale.motricity")
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
                            Text("home.scale.trunkControl")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.prim))
                                .foregroundStyle(.textOnPrim)
                                .cornerRadius(12)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        Button {
                            
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
                        
                        
                    } //VStack Scales
                } // VStack Choose Scales
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Button("home.menu.patients") {
                                router.navigate(to: .patients(mode: .browse))
                            }
                            
                            Button("home.menu.contact") {
                                router.navigate(to: .contact)
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
                
            case .contact:
                ContactView()
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
