//
//  Attribute.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 3/09/24.
//

import Foundation

struct Attribute: Decodable {
    let source: Int?
    let id, valueName: String?
    let attributeGroupID, attributeGroupName, name, valueID: String?
    let values: [AttributeValue]?
    
    enum CodingKeys: String, CodingKey {
        case source, id, name, values
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case valueID = "value_id"
    }
}
