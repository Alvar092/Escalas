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
                    
                    Text("\(viewModel.patient.age) \(String(localized: "patientDetail.years"))")
                        .font(.subheadline)
                        .foregroundStyle(.prim)
                    
                }
            } // HStack
            .padding(.horizontal)
            ScrollView{
                Text("patientDetail.test")
                    .font(.lSemi)
                    .padding(.horizontal)
                
                ForEach(viewModel.tests, id: \.id) { test in
                    NavigationLink {
                        TestDetailView(viewModel: TestDetailViewModel(test: test, patient: viewModel.patient))
                    } label: {
                        HStack{
                            VStack(alignment: .leading) {
                                Text(test.testType.rawValue)
                                    .font(.m)
                                    .foregroundStyle(.textPrim)
                                Text(test.date.formatted(date:.abbreviated, time: .omitted))
                                    .font(.s)
                                    .foregroundStyle(.textPrim)
                            }
                            
                            Spacer()
                            
                            Text("\(test.totalScore)/\(test.testType.maxScore)")
                                .font(.mSemi)
                                .foregroundStyle(.textPrim)
                        }
                    }
                }
                .padding()
            }
            
        } // VStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backg)
        .navigationTitle("paciente")
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
        history: PatientHistory(patient: Patient.patient1, bergTests: [BergTest.patient1],motricityIndexTests: [MotricityIndex.patient1], trunkControlTests: [TrunkControlTest.patient1]),
        getTestsUseCase: mockUseCase
    ))
}


