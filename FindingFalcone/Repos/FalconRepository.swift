//
//  FalconRepository.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation
import Alamofire

class FalconRepository : BaseRepository{
    
    static var instance = FalconRepository()
    
    private override init() {
        //private constructor
    }
    
    func getPlanets(onSuccess: @escaping ([PlanetData])-> Void,
                    onError: @escaping (AFError)-> Void){
        FalconService.instance.getPlanets(onSuccess: onSuccess,
                                          onError: onError)
        
    }
    
    func getVehicles(onSuccess: @escaping ([VehicleData]) -> Void,
                     onError: @escaping (AFError)-> Void){
        FalconService.instance.getVehicles(onSuccess: onSuccess,
                                           onError: onError)
    }
    
    func getToken(onSuccess: @escaping (TokenData) -> Void,
                  onError: @escaping (AFError)-> Void){
        FalconService.instance.getToken(onSuccess: onSuccess,
                                        onError: onError)
    }
    
    func findFalcon(request: FindRequest,
                    onSuccess: @escaping (FindResponse) -> Void,
                    onError: @escaping (AFError)-> Void){
        FalconService.instance.findFalcon(request: request,
                                          onSuccess: onSuccess,
                                          onError: onError)
    }
}
