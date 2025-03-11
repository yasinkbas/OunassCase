//
//  ProductDetailInteractor.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import Foundation
import NetworkManagerKit

protocol ProductDetailInteractorInterface: AnyObject {
    func fetchProductDetail(slug: String) async -> ProductListBaseAPIResponse<ProductDetailResponse>?
}

protocol ProductDetailInteractorOutput: AnyObject {
    func handleRequestError(error: Error)
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutput?
}

// MARK: - ProductDetailInteractorInterface
extension ProductDetailInteractor: ProductDetailInteractorInterface {
    func fetchProductDetail(slug: String) async -> ProductListBaseAPIResponse<ProductDetailResponse>? {
        guard let output else { return nil }
        return await ProductDetailEndpoint()
            .getDetail(slug: slug)
            .onError(output.handleRequestError(error:))
            .startAsync()
    }
}
