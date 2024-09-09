//
//  HTTPRequest.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 4/09/24.
//

import Foundation

func fetchProducts<T: Decodable>(searchType: SearchType, siteId: String, accessToken: String, modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    let urlString = searchType.endpoint(siteId: siteId)
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "URL no válida"])))
        return
    }
    
    var request = URLRequest(url: url)
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Sin datos"])))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(modelType, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}
