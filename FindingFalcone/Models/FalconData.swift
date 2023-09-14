//
//  FalconData.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation

struct TokenData : Codable {
    let token: String
}

struct FindRequest: Codable {
    var token: String
    var planetNames: [String]
    var vehicleNames: [String]
    
    enum CodingKeys: String, CodingKey {
        case token
        case planetNames = "planet_names"
        case vehicleNames = "vehicle_names"
    }
}

struct FindResponse: Codable {
    let planetName: String?
    let status: String?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case planetName = "planet_name"
        case status
        case error
    }
}
