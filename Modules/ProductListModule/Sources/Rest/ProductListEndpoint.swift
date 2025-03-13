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

    func getList(for startIndex: String?) -> NLTaskDirector<ProductListBaseAPIResponse<ProductListResponse>, Empty> {
        NLTaskPoint(client: client)
            .path("/api/v2/women/clothing")
            .addParameter(.init(name: "fh_start_index", value: startIndex ?? "0"))
            .method(.get)
            .build().and.direct()
    }
}
