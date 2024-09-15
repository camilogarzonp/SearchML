//
//  SearchViewVMTests.swift
//  SearchingMLTests
//
//  Created by Juan Camilo Garzon Patino on 13/09/24.
//

import XCTest
@testable import SearchingML

class SearchViewVMTests: XCTestCase {
    
    var viewModel: SearchViewVM!
    var mockService: MockProductService!
    
    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        viewModel = SearchViewVM(productService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testSearchProductSuccess() {
        let paging = Paging(total: 1, offset: 1, limit: 1, primaryResults: 1)
        let Item = Item(id: "1", siteID: "1", title: "test", seller: nil, price: 0.0, currencyID: "", availableQuantity: 0, buyingMode: "", listingTypeID: "", stopTime: "", condition: "", permalink: "", thumbnail: "", acceptsMercadopago: false, installments: nil, address: nil, shipping: nil, sellerAddress: nil, attributes: nil, differentialPricing: nil, originalPrice: nil, categoryID: "", officialStoreID: nil, catalogProductID: nil, tags: nil, catalogListing: false)
        
        // Given
        mockService.shouldReturnError = false
        mockService.mockResponse = Response(siteID: "", query: nil, paging: paging, results: [Item])
        
        // When
        viewModel.searchProduct(text: "test")
        
        // Then
        XCTAssertNotNil(viewModel.products)
        XCTAssertFalse(viewModel.showProgress)
    }
    
    func testSearchProductFailure() {
        // Given
        mockService.shouldReturnError = true
        
        // When
        viewModel.searchProduct(text: "test")
        
        // Then
        XCTAssertNil(viewModel.products)
        XCTAssertFalse(viewModel.showProgress)
    }
}

