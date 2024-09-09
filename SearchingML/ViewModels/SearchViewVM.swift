//
//  SearchViewVM.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 5/09/24.
//

import Foundation

class SearchViewVM : ObservableObject {
    
    func searchProduct(product: String) {
        fetchData(product: product)
    }
    
    private func fetchData(product: String) {
        let productQueryParams = ["q": product]

        if let productURL = buildURL(baseURL: EndpointURL.baseURL, path: EndpointURL.searchPath, queryParams: productQueryParams) {
            let accessToken = "tu_access_token"
            
            performRequest(url: productURL, accessToken: accessToken) { (products: [Item]?) in
                if let products = products {
                    for product in products {
                        print("Producto: \(product.title), Precio: \(product.price)")
                    }
                } else {
                    print("No se encontraron productos o hubo un error.")
                }
            }
        }

    }
}
