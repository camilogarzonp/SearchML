//
//  SellerAddress.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct SellerAddress: Decodable {
    let country: Location
    let state: Location
    let city: Location
    let latitude, longitude: String
}
