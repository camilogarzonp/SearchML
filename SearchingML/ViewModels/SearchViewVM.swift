//
//  SearchViewVM.swift
//  SearchingML
//
//  Created by Juan Camilo Garzon Patino on 5/09/24.
//

import Foundation

class SearchViewVM : ObservableObject {
    
    @Published var response: Response? = nil
    @Published var products: [Item]? = nil
    @Published var currentCategory: CategorySearch? = nil
    @Published var categories: [CategorySearch]?
    @Published var showProgress: Bool = false
    var lastTextSearch: String = ""
    
    private let accessToken = "tu_access_token"
    
    init() {
        self.fetchDataCategories()
    }
    
    func searchProduct(text: String) {
        let product = text.replacingSpaces(with: "%20")
        
        if lastTextSearch.lowercased() != product.lowercased() {
            lastTextSearch = product
            fetchData(product: product)
        }
    }
    
    func searchCategory(categoryID: String) {
        fetchDataCategory(categoryID: categoryID)
    }
    
    private func fetchData(product: String) {
        self.showProgress = true
        self.response = nil
        self.products = nil
        
        fetchProducts(searchType: .text(query: product), siteId: "MLA", accessToken: self.accessToken, modelType: Response?.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.response = response
                    self.products = response?.results
                    self.showProgress = false
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchDataCategories() {
        self.showProgress = true
        self.categories = nil
        
        fetchProducts(searchType: .categories, siteId: "MLA", accessToken: self.accessToken, modelType: [CategorySearch].self) { result in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self.categories = categories
                    self.showProgress = false
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchDataCategory(categoryID: String) {
        self.showProgress = true
        self.response = nil
        self.products = nil
        
        fetchProducts(searchType: .category(id: categoryID), siteId: "MLA", accessToken: self.accessToken, modelType: Response?.self) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.response = response
                    self.products = response?.results
                    self.showProgress = false
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
