//
//  ProductListBaseAPIResponse.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

public struct ProductListBaseAPIResponse<Result: Decodable>: Decodable {
    public let routeType: String?
    public let l2CategoryUrl: String?
    public let deepLink: String?
    public let department: String?
    public let categoryUrl: String?
    public let plpResult: Result?
    public let pdpResult: Result?
    
    enum CodingKeys: String, CodingKey {
        case routeType
        case l2CategoryUrl
        case deepLink
        case department
        case categoryUrl
        case plpResult = "plp"
        case pdpResult = "pdp"
    }
}
