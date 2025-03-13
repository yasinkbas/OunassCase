//
//  ProductListInteractor.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation
import NetworkManagerKit

protocol ProductListInteractorInterface: AnyObject {
    func getStartIndex(for pageHref: String) -> Int
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
    func getStartIndex(for pageHref: String) -> Int {
        let components = URLComponents(string: pageHref)
        let startIndex = Int(components?.queryItems?.first(where: { $0.name == "fh_start_index" })?.value ?? "0") ?? .zero
        return startIndex
    }
    
    func fetchProducts(for startIndex: Int) async -> ProductListBaseAPIResponse<ProductListResponse>? {
        guard let output else { return nil }
        return await ProductListEndpoint()
            .getList(for: String(startIndex))
            .onError(output.handleRequestError(error:))
            .startAsync()
    }
}
