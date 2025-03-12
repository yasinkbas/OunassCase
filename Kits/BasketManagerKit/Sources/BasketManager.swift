//
//  BasketManager.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import Foundation

public protocol BasketManagerInterface: AnyObject {
    func addProduct(_ product: AddToBasketProduct)
    func removeProduct(with id: String)
    func isInBasket(productId: String) -> Bool
    func getAllProducts() -> [AddToBasketProduct]
}

public class BasketManager: BasketManagerInterface {
    public static let shared: BasketManager = .init()
    
    private var products: [AddToBasketProduct] = []
    
    private init() {}

    public func addProduct(_ product: AddToBasketProduct) {
        guard !isInBasket(productId: product.id) else { return }
        products.append(product)
    }

    public func removeProduct(with id: String) {
        products.removeAll { $0.id == id }
    }

    public func isInBasket(productId: String) -> Bool {
        products.contains { $0.id == productId }
    }

    public func getAllProducts() -> [AddToBasketProduct] {
        products
    }
}
