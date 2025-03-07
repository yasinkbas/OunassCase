//
//  ProductListInteractor.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation
import NetworkManagerKit

protocol ProductListInteractorInterface: AnyObject {
    func fetchProducts(for startIndex: Int) async -> ProductListBaseAPIResponse<ProductListResponse>?
}

protocol ProductListInteractorOutput: AnyObject {
    func handleRequestError(error: Error)
    
}

final class ProductListInteractor {
    weak var output: ProductListInteractorOutput?
}

// MARK: - ProductListInteractorInterface
extension ProductListInteractor: ProductListInteractorInterface { 
    func fetchProducts(for startIndex: Int) async -> ProductListBaseAPIResponse<ProductListResponse>? {
        guard let output else { return nil }
        print("--> request started \(startIndex)")
        return await ProductListEndpoint()
            .getList(for: String(startIndex))
            .onError(output.handleRequestError(error:))
            .startAsync()
    }
}
