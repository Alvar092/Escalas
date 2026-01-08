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
   
    var body: some View {
        NavigationStack {
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
                        NavigationLink("Berg Test") {
                            ScaleMenuView(testType: .berg)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        
                        
                        NavigationLink("Time Up & Go") {
                            /* goToTUG */
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor.gradient)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        
                        NavigationLink("10 Metres Walking Test") {
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
                            NavigationLink("Pacientes") {
                                PatientsView(mode: .browse)
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
        }
    }
}

#Preview {
    HomeView()
}
