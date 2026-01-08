//
//  ScaleView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 3/12/25.
//

import SwiftUI

struct ScaleMenuView: View {
    
    struct ScaleInfoView: View {
        var body: some View {
            Text("Información de la escala")
                .font(.title)
        }
    }
    
    struct ScaleExecutionView: View {
        var body: some View {
            Text("Realización de la prueba")
                .font(.title)
        }
    }
    
    @State private var selectedPatient: Patient?
    @State private var showingPatientSelection = false
    let testType: TestType
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack (alignment: .center, spacing: 24) {
                    Text(testType.displayName)
                        .font(.title.bold())
                        .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 12){
                        Button {
                            showingPatientSelection = true
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(selectedPatient != nil ? Color.accentColor.opacity(0.2): Color.gray.opacity(0.1))
                                        .frame(width: 32, height: 32)
                                    if let patient = selectedPatient {
                                        Text(String(patient.name.prefix(2).uppercased()))
                                            .font(.caption.bold())
                                            .foregroundColor(.accentColor)
                                    } else {
                                        Image(systemName: "person.fill")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                    }
                                }
                                
                                Text(selectedPatient?.name ?? "Seleccionar paciente")
                                    .foregroundStyle(selectedPatient != nil ? .primary: .primary)
                                
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(20)
                            .background(Color.accentColor.gradient)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        NavigationLink {
                            ScaleInfoView()
                        } label: {
                            Text("Información de la prueba")
                                .frame(maxWidth: .infinity)
                                .padding(32)
                                .background(Color.accentColor.gradient)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                        
                        NavigationLink {
                            ScaleExecutionView()
                        } label: {
                            Text("Comenzar prueba")
                                .frame(maxWidth: .infinity)
                                .padding(48)
                                .background(
                                    selectedPatient != nil ?
                                    Color.accentColor.gradient: Color.gray.gradient
                                )
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12,style: .continuous))
                        }
                        .disabled(selectedPatient == nil)
                    } // VStack
                    .padding(4.0)
                } // VStack nombre escala
            } // VStack general
        } // Nav Stack
        .sheet(isPresented: $showingPatientSelection) {
            NavigationStack {
                PatientsView(mode:.select) { patient in
                    selectedPatient = patient
                }
            }
        }
    }
}

#Preview {
    ScaleMenuView(testType: .berg)
}
