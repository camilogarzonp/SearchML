//
//  AttributeValue.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct AttributeValue: Decodable {
    //let structValue: String?
    let source: Int?
    let id, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        //case structValue = "struct"
        case source
    }
}
