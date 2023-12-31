//
//  ResultView.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 11/09/23.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject var viewModel = ResultViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var findRequest: FindRequest?
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            if viewModel.findResponse.error == nil {
                Text("Success! Congratulations on Finding Falcone. King Shah is mighty pleased.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(20)
                Text("Planet found: \(viewModel.findResponse.planetName!)")
            } else {
                Text(viewModel.findResponse.error ?? "")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(24)
            }
            primaryButton("Start Again")
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
        }
        .accentColor(.black)
        .navigationTitle("Finding Falcone!")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            if let findRequest = findRequest {
                viewModel.findFalcon(findRequest: findRequest)
            }
        }
    }
}
