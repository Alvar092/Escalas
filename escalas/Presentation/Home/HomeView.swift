//
//  HomeView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct HomeView: View {
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
                } // VStack 1
                VStack(alignment: .center, spacing: 20) {
                    Text("Elige una escala para comenzar")
                        .font(.headline)
                    VStack(spacing: 12) {
                        Button(action: { /* goToBerg */ }) {
                            Text("Berg Test")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        Button(action: { /* goToTuG */ }) {
                            Text("Time Up & Go")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        Button(action: { /* goTo10MWT */ }) {
                            Text("10 Metres Walking Test")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                    } //VStack Escalas
                } // VStack Padre
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {}) {
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
