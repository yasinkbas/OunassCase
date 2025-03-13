//
//  MockProductListInteractor.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

@testable import ProductListModule
import NetworkManagerKit

final class MockProductListInteractor: ProductListInteractorInterface {
    var invokedGetStartIndex = false
    var invokedGetStartIndexCount = 0
    var invokedGetStartIndexParameters: (pageHref: String, Void)?
    var invokedGetStartIndexParametersList = [(pageHref: String, Void)]()
    var stubbedGetStartIndexResult: Int! = 0

    func getStartIndex(for pageHref: String) -> Int {
        invokedGetStartIndex = true
        invokedGetStartIndexCount += 1
        invokedGetStartIndexParameters = (pageHref, ())
        invokedGetStartIndexParametersList.append((pageHref, ()))
        return stubbedGetStartIndexResult
    }

    var invokedFetchProducts = false
    var invokedFetchProductsCount = 0
    var invokedFetchProductsParameters: (startIndex: Int, Void)?
    var invokedFetchProductsParametersList = [(startIndex: Int, Void)]()
    var stubbedFetchProductsResponse: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>?

    func fetchProducts(for startIndex: Int) async -> NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>? {
        invokedFetchProducts = true
        invokedFetchProductsCount += 1
        invokedFetchProductsParameters = (startIndex, ())
        invokedFetchProductsParametersList.append((startIndex, ()))
        return stubbedFetchProductsResponse
    }
}
