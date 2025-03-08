//
//  MockProductListInteractor.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

@testable import ProductList
import NetworkManagerKit

final class MockProductListInteractor: ProductListInteractorInterface {
    var invokedFetchProducts = false
    var invokedFetchProductsCount = 0
    var invokedFetchProductsParameters: (startIndex: Int, Void)?
    var invokedFetchProductsParametersList = [(startIndex: Int, Void)]()
    var stubbedFetchProductsResponse: NetworkManagerKit.ProductListBaseAPIResponse<ProductList.ProductListResponse>?

    func fetchProducts(for startIndex: Int) async -> NetworkManagerKit.ProductListBaseAPIResponse<ProductList.ProductListResponse>? {
        invokedFetchProducts = true
        invokedFetchProductsCount += 1
        invokedFetchProductsParameters = (startIndex, ())
        invokedFetchProductsParametersList.append((startIndex, ()))
        return stubbedFetchProductsResponse
    }
}
