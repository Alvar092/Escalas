//
//  PatientDetailView.swift
//  escalas
//
//  Created by Álvaro Entrena Casas on 16/12/25.
//

import SwiftUI

struct PatientDetailView: View {
    @Environment(\.repositories) private var repositories
    
    @State var viewModel: PatientDetailViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            HStack (spacing: 16) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.secondary)
                
                VStack (alignment: .leading, spacing: 4) {
                    
                    Text(viewModel.patient.name)
                        .font(.lSemi)
                        .foregroundStyle(.prim)
                    
                    Text("\(viewModel.patient.age) años")
                        .font(.subheadline)
                        .foregroundStyle(.prim)
                    
                }
            } // HStack
            .padding(.horizontal)
            ScrollView{
                Text("Tests")
                    .font(.lSemi)
                    .padding(.horizontal)
                
                ForEach(viewModel.tests, id: \.id) { test in
                    HStack{
                        VStack(alignment: .leading) {
                            Text(test.testType.rawValue)
                                .font(.m)
                            Text(test.date.formatted(date:.abbreviated, time: .omitted))
                                .font(.s)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Text("\(test.totalScore)/\(test.testType.maxScore)")
                            .font(.mSemi)
                    }
                }
                .padding()
            }
            
        } // VStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backg)
        .navigationTitle("Paciente")
        .navigationBarTitleDisplayMode(.inline)
        
        .task {
            try? await viewModel.getPatientTests()
        }
        
    }
}

#Preview {
    let mockUseCase = MockGetPatientTestsUseCase()
    
    PatientDetailView(viewModel: PatientDetailViewModel(
        patient: Patient.patient1,
        history: PatientHistory(patient: Patient.patient1, bergTests: [BergTest.patient1]),
        getTestsUseCase: mockUseCase
    ))
}


