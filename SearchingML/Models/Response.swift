//
//  Response.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Response: Decodable {
    let siteID: String
    let query: String?
    let paging: Paging
    let results: [Item]

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case query, paging, results
    }
}
