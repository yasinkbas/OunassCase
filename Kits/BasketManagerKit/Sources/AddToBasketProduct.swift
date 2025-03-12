//
//  AddToBasketProduct.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import Foundation

public struct AddToBasketProduct {
    let id: String
    public let name: String
    public let size: String
    
    public init(id: String, name: String, size: String) {
        self.id = id
        self.name = name
        self.size = size
    }
}
