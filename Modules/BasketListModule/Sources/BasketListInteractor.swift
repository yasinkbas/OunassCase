//
//  BasketListInteractor.swift
//  BasketListModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import Foundation

protocol BasketListInteractorInterface: AnyObject {

}

protocol BasketListInteractorOutput: AnyObject {
    
}

final class BasketListInteractor {
    weak var output: BasketListInteractorOutput?
}

// MARK: - BasketListInteractorInterface
extension BasketListInteractor: BasketListInteractorInterface { 

}
