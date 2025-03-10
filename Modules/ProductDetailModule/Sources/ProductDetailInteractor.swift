//
//  ProductDetailInteractor.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import Foundation

protocol ProductDetailInteractorInterface: AnyObject {

}

protocol ProductDetailInteractorOutput: AnyObject {
    
}

final class ProductDetailInteractor {
    weak var output: ProductDetailInteractorOutput?
}

// MARK: - ProductDetailInteractorInterface
extension ProductDetailInteractor: ProductDetailInteractorInterface { 

}
