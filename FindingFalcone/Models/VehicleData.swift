//
//  VehicleData.swift
//  FindingFalcone
//
//  Created by Mahi Garg on 13/09/23.
//

import Foundation

struct VehicleData: Codable, Hashable {
    var name: String
    var totalNo: Int
    var maxDistance: Int
    var speed: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case totalNo = "total_no"
        case maxDistance = "max_distance"
        case speed
    }
}
