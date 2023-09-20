//
//  SearchViewModel.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation
import Alamofire

class SearchViewModel: BaseViewModel, ObservableObject {
    @Published var planets: [PlanetData] = []
    @Published var vehicles: [VehicleData] = []
    @Published var selectedVehicle: Int = 0
    @Published var selectedPlanet: Int = 0
    @Published var findRequest: FindRequest = FindRequest(token: "",
                                                          planetNames: [],
                                                          vehicleNames: [])
    @Published var timeTaken: Int = 0
    @Published var findFalconePlanet: [PlanetData] = Array(repeating: PlanetData(name: "Select",
                                                                                 distance: 0),
                                                           count: 4)
    @Published var findFalconeVehicle: [VehicleData] = Array(repeating: VehicleData(name: "",
                                                                                    totalNo: 0,
                                                                                    maxDistance: 0,
                                                                                    speed: 0),
                                                             count: 4)
    
    func initializePlanetVehicleData() {
        self.timeTaken = 0
        self.selectedVehicle = 0
        self.selectedPlanet = 0
        self.findFalconePlanet = Array(repeating: PlanetData(name: "Select",
                                                             distance: 0),
                                       count: 4)
        self.findFalconeVehicle = Array(repeating: VehicleData(name: "",
                                                               totalNo: 0,
                                                               maxDistance: 0,
                                                               speed: 0),
                                        count: 4)
        self.fetchPlanets()
        self.fetchVehicles()
    }
    
    func setupRequestParameter(completion: ()-> Void) {
        self.fetchToken()
        self.findRequest.planetNames = self.findFalconePlanet.map { $0.name }
        self.findRequest.vehicleNames = self.findFalconeVehicle.map { $0.name }
        completion()
    }
    
    func selectPlanet(_ planet: PlanetData,
                      _ index: Int) {
        self.findFalconePlanet[index] = planet
        self.selectedPlanet = self.findFalconePlanet.filter { $0.name != "Select" }.count
    }
    
    func selectVehicle(_ vehicle: VehicleData,
                       _ index: Int) {
        self.findFalconeVehicle[index] = vehicle
        self.timeTaken += self.findFalconePlanet[index].distance / vehicle.speed
        self.selectedVehicle = self.findFalconeVehicle.filter { $0.name != "" }.count
    }
    
    func vehicleCount(_ vehicle: VehicleData)-> Int {
        return vehicle.totalNo - self.findFalconeVehicle.filter { item in item.name == vehicle.name }.count
    }
}

extension SearchViewModel {
    func fetchPlanets() {
        FalconRepository.instance.getPlanets { data in
            self.planets = data
        } onError: { error in
            self.afError = error
        }
    }
    
    func fetchVehicles() {
        FalconRepository.instance.getVehicles{ data in
            self.vehicles = data
        } onError: { error in
            self.afError = error
        }
    }
    
    func fetchToken() {
        FalconRepository.instance.getToken{ data in
            self.findRequest.token = data.token
        } onError: { error in
            self.afError = error
        }
    }
    
    
}
