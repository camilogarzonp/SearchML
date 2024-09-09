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
    
    private let accessToken = "tu_access_token"
    
    init() {
        self.fetchDataCategories()
    }
    
    func searchProduct(text: String) {
        fetchData(product: text)
    }
    
    func searchCategory(categoryID: String) {
        fetchDataCategory(categoryID: categoryID)
    }
    
    private func fetchData(product: String) {
        self.showProgress = true
        self.response = nil
        self.products = nil
        
        fetchProducts(searchType: .text(query: product.replacingSpaces(with: "%20")
                                       ), siteId: "MLA", accessToken: self.accessToken, modelType: Response?.self) { result in
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
