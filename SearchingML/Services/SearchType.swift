//
//  SearchType.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 4/09/24.
//

import Foundation

enum SearchType {
    case text(query: String)
    case category(id: String)
    case seller(id: String)
    case nickname(name: String)
    case sellerNCategory(sellerID: String, categoryID: String)
    case categories

    func endpoint(siteId: String) -> String {
        let baseUrl = "https://api.mercadolibre.com/sites/\(siteId)/"
        switch self {
        case .text(let query):
            return "\(baseUrl)search?q=\(query)"
        case .category(let id):
            return "\(baseUrl)search?category=\(id)"
        case .seller(let id):
            return "\(baseUrl)search?seller_id=\(id)"
        case .nickname(let name):
            return "\(baseUrl)search?nickname=\(name)"
        case .sellerNCategory(let sellerID, let categoryID):
            return "\(baseUrl)search?seller_id=\(sellerID)&category=\(categoryID)"
        case .categories:
            return "\(baseUrl)categories"
        }
    }
}


