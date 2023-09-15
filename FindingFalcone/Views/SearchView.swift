//
//  SearchView.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 11/09/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    @State var isDestinationActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        Text("Select planets you want to search in:")
                            .font(.title)
                            .multilineTextAlignment(.center)
                        ForEach(0..<4) { index in
                            destination(index: index)
                        }
                        
                        NavigationLink(destination: ResultView(findRequest: Binding.constant(viewModel.findRequest)).navigationBarBackButtonHidden(true),
                                       isActive: $isDestinationActive,
                                       label: EmptyView.init)
                    }
                    .accentColor(.black)
                    .navigationTitle("Finding Falcone!")
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationBarItems(trailing: resetButton)
                    .onAppear {
                        viewModel.initializePlanetVehicleData()
                    }
                }
                VStack {
                    timeTakenView
                    findFalconeButton
                }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                    .background(Color.gray.opacity(0.3))
            }
        }
    }
    
    var timeTakenView: some View {
        Text("Time Taken by (\(viewModel.selectedPlanet <= viewModel.selectedVehicle ? viewModel.selectedPlanet : viewModel.selectedVehicle )/4): \(viewModel.timeTaken)")
            .font(.headline)
    }
    
    var findFalconeButton: some View {
        Button(action: {
            viewModel.setupRequestParameter {
                isDestinationActive = true
            }
        }, label: {
            primaryButton("Find Falcone")

        })
        .accentColor(.black)
        .disabled(viewModel.findFalconePlanet.contains { $0.name == "Select" } || viewModel.findFalconeVehicle.contains { $0.name == "" })
    }
    
    var resetButton: some View {
        Button { viewModel.initializePlanetVehicleData()
        } label: {
            Text("Reset").foregroundColor(.black)
        }
        
    }
    
    func destination(index: Int)-> some View {
        let showPlanets = viewModel.planets.filter { !viewModel.findFalconePlanet.contains($0) }
        return VStack {
            Text("Destination \(index + 1)")
            Menu {
                ForEach(showPlanets, id: \.self) { planet in
                    Button(action: {
                        viewModel.selectPlanet(planet, index)
                    },
                           label: { Text(planet.name) }
                    )
                }
            } label: {
                selectbutton(index: index)
            }
            
            if viewModel.findFalconePlanet[index].name != "Select" {
                VStack(alignment: .leading) {
                    ForEach(viewModel.vehicles, id: \.self) { vehicle in
                        if vehicle.maxDistance >= viewModel.findFalconePlanet[index].distance {
                            vehicleList(vehicle: vehicle, index: index)
                        }
                    }
                }
            }
        }
    }
    
    func vehicleList(vehicle: VehicleData, index: Int)-> some View {
        Button(action: {
            viewModel.selectVehicle(vehicle, index)
        }) {
            HStack {
                Image(systemName: viewModel.findFalconeVehicle[index] == vehicle ?  "checkmark.circle.fill" : "circle")
                Text(vehicle.name + " (" + String(vehicle.totalNo) + ")")
            }
        }
        .disabled(vehicle.maxDistance < viewModel.findFalconePlanet[index].distance)
        
        
    }
    
    func selectbutton(index: Int)-> some View {
        HStack {
            Text(viewModel.findFalconePlanet[index].name)
            Image(systemName: "arrowtriangle.down.fill")
                .padding(.leading)
        }
        .frame(width: 124)
        .padding(8)
        .border(.black)
    }
}

func primaryButton(_ name: String)-> some View {
    Text(name)
        .frame(width: 102, height: 36)
        .padding(4)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black,
                radius: 4,
                x: 0,
                y: 4)
}
