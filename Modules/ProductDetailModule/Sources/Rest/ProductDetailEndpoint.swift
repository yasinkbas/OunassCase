//
//  ProductDetailEndpoint.swift
//  OunassCase
//
//  Created by Yasin Akbas on 11.03.2025.
//

import NLab
import NetworkManagerKit

final class ProductDetailEndpoint {
    let client = NetworkClientHandler.client()
    
    init() { }
    

    func getDetail(slug: String) -> NLTaskDirector<ProductListBaseAPIResponse<ProductDetailResponse>, Empty> {
        NLTaskPoint(client: client)
            .path("/api/v2/\(slug).html")
            .method(.get)
            .build().and.direct()
    }
}
