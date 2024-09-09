//
//  ApiRequest.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 4/09/24.
//

import Foundation

enum ApiRequest {
    case search(siteID: String, q: String)
    case searchCategory(siteID: String, categoryID: String)
    case searchSellerID(siteID: String, sellerID: String)
    case searchNikeName(siteID: String, nickName: String)
    case searchSellerIDNCategory(siteID: String, sellerID: String, categoryID: String)
    case listAllItemsSeller(userID: String)
    
    var path: String {
        switch self {
        case .search(siteID: let siteID, q: let q):
            return "/sites/\(siteID)/search?q=\(q)"
        case .searchCategory(siteID: let siteID, categoryID: let categoryID):
            return "sites/\(siteID)/search?category=\(categoryID)"
        case .searchSellerID(siteID: let siteID, sellerID: let sellerID):
            return "/sites/\(siteID)/search?seller_id=\(sellerID)"
        case .searchNikeName(siteID: let siteID, nickName: let nickName):
            return "/sites/\(siteID)/search?nickname=\(nickName)"
        case .searchSellerIDNCategory(siteID: let siteID, sellerID: let sellerID, categoryID: let categoryID):
            return "/sites/\(siteID)/search
        case .listAllItemsSeller(userID: let userID):
            return "/users/\(userID)/items/search"
        }
    }
}

enum SearchType {
    case text(query: String)
    case category(id: String)
    case seller(id: String)
    case nickname(name: String)
    case sellerNCategory(sellerID: String, categoryID: String)

    func endpoint(siteId: String) -> String {
        let baseUrl = "https://api.mercadolibre.com/sites/\(siteId)/search"
        switch self {
        case .text(let query):
            return "\(baseUrl)?q=\(query)"
        case .category(let id):
            return "\(baseUrl)?category=\(id)"
        case .seller(let id):
            return "\(baseUrl)?seller_id=\(id)"
        case .nickname(let name):
            return "\(baseUrl)?nickname=\(name)"
        case .sellerNCategory(let sellerID, let categoryID):
            return "\(baseUrl)?seller_id=\(sellerID)&category=\(categoryID)"
        }
    }
}


