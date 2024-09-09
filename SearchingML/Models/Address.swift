//
//  Address.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Address: Decodable {
    let stateID, stateName, cityID, cityName: String
    
    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
}
