//
//  FalconService.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation
import Alamofire

class FalconService : BaseService {
    
    private let planetsEndpoint = "/planets"
    private let vehiclesEndpoint = "/vehicles"
    private let tokenEndpoint = "/token"
    private let tokenHeaders: HTTPHeaders = [ "Accept": "application/json" ]
    private let findEndpoint = "/find"
    private let findHeaders: HTTPHeaders = [ "Accept": "application/json" ,
                                             "Content-Type": "application/json"]
    
    static var instance = FalconService()
    
    private override init() {
        //private constructor
    }
    
    func getPlanets(onSuccess: @escaping ([PlanetData])-> Void,
                    onError: @escaping (AFError)-> Void){
        makeGetRequest(endpoint: planetsEndpoint,
                       onSuccess: onSuccess,
                       onError: onError)
        
    }
    
    func getVehicles(onSuccess: @escaping ([VehicleData]) -> Void,
                     onError: @escaping (AFError)-> Void){
        makeGetRequest(endpoint: vehiclesEndpoint,
                       onSuccess: onSuccess,
                       onError: onError)
        
    }
    
    func getToken(onSuccess: @escaping (TokenData) -> Void,
                  onError: @escaping (AFError)-> Void){
        makePostRequest(endpoint: tokenEndpoint,
                        header: tokenHeaders,
                        onSuccess: onSuccess,
                        onError: onError)
    }
    
    func findFalcon(request: FindRequest,
                    onSuccess: @escaping (FindResponse) -> Void,
                    onError: @escaping (AFError)-> Void){
        makePostRequest(endpoint: findEndpoint,
                        header: findHeaders,
                        body: request.dictionary,
                        onSuccess: onSuccess,
                        onError: onError)
    }
}
