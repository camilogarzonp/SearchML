//
//  Item.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Item: Decodable, Hashable {
    let id, siteID, title: String
    let seller: Seller?
    let price: Double
    let currencyID: String
    let availableQuantity: Int
    let buyingMode, listingTypeID, stopTime, condition: String
    let permalink: String
    let thumbnail: String
    let acceptsMercadopago: Bool
    let installments: Installments?
    let address: Address?
    let shipping: Shipping?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]?
    let differentialPricing: DifferentialPricing?
    let originalPrice: Double?
    let categoryID: String
    let officialStoreID: Int?
    let catalogProductID: String?
    let tags: [String]?
    let catalogListing: Bool
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, seller, price, condition, permalink, thumbnail, installments, address, shipping, attributes, tags
        case siteID = "site_id"
        case currencyID = "currency_id"
        case availableQuantity = "available_quantity"
        case buyingMode = "buying_mode"
        case listingTypeID = "listing_type_id"
        case stopTime = "stop_time"
        case acceptsMercadopago = "accepts_mercadopago"
        case sellerAddress = "seller_address"
        case differentialPricing = "differential_pricing"
        case originalPrice = "original_price"
        case categoryID = "category_id"
        case officialStoreID = "official_store_id"
        case catalogProductID = "catalog_product_id"
        case catalogListing = "catalog_listing"
    }
}
