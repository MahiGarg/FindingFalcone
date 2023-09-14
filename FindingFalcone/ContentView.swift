//
//  ContentView.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 11/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    @State var isDestinationActive = false
    @State var selectedVehicle: Int = 0
    @State var selectedPlanet: Int = 0
    
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
                    Text("Time Taken by (\(selectedPlanet <= selectedVehicle ? selectedPlanet : selectedVehicle )/4): \(viewModel.timeTaken)")
                        .font(.headline)
                    findFalconeButton
                }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 16)
                    .background(Color.gray.opacity(0.3))
            }
        }
    }
    
    var findFalconeButton: some View {
        Button(action: {
            viewModel.setupRequestParameter {
                isDestinationActive = true
            }
        }, label: {
            Text("Find Falcone")
                .padding(4)
                .border(.black)

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
                        viewModel.findFalconePlanet[index] = planet
                        selectedPlanet = viewModel.findFalconePlanet.filter { $0.name != "Select" }.count
                    },
                           label: { Text(planet.name) }
                    )
                }
            } label: {
                selectbutton(index: index)
            }
            
            VStack(alignment: .leading) {
                ForEach(viewModel.vehicles, id: \.self) { vehicle in
                    vehicleList(vehicle: vehicle, index: index)
                }
            }
        }
    }
    
    func vehicleList(vehicle: VehicleData, index: Int)-> some View {
        Button(action: {
            viewModel.findFalconeVehicle[index] = vehicle
            viewModel.timeTaken += viewModel.findFalconePlanet[index].distance / vehicle.speed
            selectedVehicle = viewModel.findFalconeVehicle.filter { $0.name != "" }.count
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
        }
        .frame(width: 102)
        .padding(8)
        .border(.black)
    }
}
