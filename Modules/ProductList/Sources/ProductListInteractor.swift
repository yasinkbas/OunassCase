//
//  ProductListInteractor.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation

protocol ProductListInteractorInterface: AnyObject {

}

protocol ProductListInteractorOutput: AnyObject {
    
}

final class ProductListInteractor {
    weak var output: ProductListInteractorOutput?
}

// MARK: - ProductListInteractorInterface
extension ProductListInteractor: ProductListInteractorInterface { 

}
