//
//  NetworkClientHandler.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import Foundation
import NLab

public class NetworkClientHandler {
    private static var baseUrl: URL {
        return URL(string: "https://www.ounass.ae")!
    }
    
    public static func client() -> NLClient {
        NLClient(baseURL: baseUrl, session: .shared)
    }
}
