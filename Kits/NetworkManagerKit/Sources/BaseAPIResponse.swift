//
//  BaseAPIResponse.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

public struct BaseAPIResponse<Result: Decodable>: Decodable {
    let routeType: String?
    let l2CategoryUrl: String?
    let deepLink: String?
    let department: String?
    let categoryUrl: String?
    let data: Result?
    
    enum CodingKeys: String, CodingKey {
        case routeType, l2CategoryUrl, deepLink, department, categoryUrl
        case data = "plp"
    }
}
