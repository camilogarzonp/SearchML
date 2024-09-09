//
//  Seller.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Seller: Decodable {
    let id: Int
    let nickname: String
    let powerSellerStatus: String?
    let carDealer, realEstateAgency: Bool?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, tags, nickname
        case powerSellerStatus = "power_seller_status"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
    }
}
