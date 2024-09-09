//
//  Paging.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Paging: Decodable {
    let total, offset, limit, primaryResults: Int

    enum CodingKeys: String, CodingKey {
        case total, offset, limit
        case primaryResults = "primary_results"
    }
}
