//
//  MockProductService.swift
//  SearchingMLTests
//
//  Created by Juan Camilo Garzon Patino on 13/09/24.
//

import Foundation
@testable import SearchingML

class MockProductService: ProductServiceProtocol {
    var shouldReturnError = false
    var mockResponse: Response? = nil
    var mockCategories: [CategorySearch]? = nil
    
    func fetchProducts<T: Decodable>(searchType: SearchType, siteId: String, accessToken: String, modelType: T.Type, completion: @escaping (Result<T?, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Mock error"])))
        } else {
            if let response = mockResponse as? T {
                completion(.success(response))
            } else if let categories = mockCategories as? T {
                completion(.success(categories))
            } else {
                completion(.success(nil))
            }
        }
    }
}
