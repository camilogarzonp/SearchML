//
//  Installments.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Installments: Decodable {
    let quantity: Int
    let amount: Double
    let rate: Double
    let currencyID: String
    
    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
    }
}
