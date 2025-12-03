//
//  ScaleView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct ScaleMenuView: View {
    
    @State private var selectedPatient: String?
    
    var body: some View {
        NavigationStack {
            VStack{
                VStack (alignment: .center, spacing: 24) {
                    Text("Nombre de la escala")
                        .font(.title.bold())
                    Spacer()
                    VStack(alignment: .center, spacing: 12){
                        Button(action: {
                            // Acción para seleccionar paciente
                        }) {
                            HStack {
                                // Una simple casilla visual (puedes personalizarla)
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        // Si hay paciente, muestra un icono o iniciales
                                        Group {
                                            if let patient = selectedPatient {
                                                Text(String(patient.prefix(2)))
                                                    .font(.caption)
                                                    .foregroundColor(.accentColor)
                                            }
                                        }
                                    )
                                Text(selectedPatient ?? "Seleccionar paciente")
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.gradient)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        Button(action: {/* Seleccionar paciente */}) {
                            Text("Info")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                        Button(action: {/* Seleccionar paciente */}) {
                            Text("Comenzar prueba")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                    } // VStack
                } // VStack nombre escala
            } // VStack general 
        } // Nav Stack
    }
}

#Preview {
    ScaleMenuView()
}
