//
//  ProductListEndpoint.swift
//  OunassCase
//
//  Created by Yasin Akbas on 5.03.2025.
//

import NLab
import NetworkManagerKit

final class ProductListEndpoint {
    let client = NetworkClientHandler.client()
    
    init() { }
    
    func getList() -> NLTaskDirector<ProductListBaseAPIResponse<ProductListResponse>, Empty> {
        NLTaskPoint(client: client)
            .path("/api/v2/women/clothing")
            .method(.get)
            .build().and.direct()
    }
    
    // TODO: pagination
//    func getProduct(for page: String) -> NLTaskDirector<BaseAPIResponse<ProductListResponse>, Empty> {
//        NLTaskPoint(client: client)
//            .path("")
//            .method(.get)
//            .build().and.direct()
//    }
}
