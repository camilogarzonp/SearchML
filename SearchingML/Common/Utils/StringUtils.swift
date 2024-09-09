//
//  StringUtils.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 5/09/24.
//

import Foundation

extension String {
    func replacingSpaces(with string: String) -> String {
        return self.replacingOccurrences(of: " ", with: string)
    }
}
