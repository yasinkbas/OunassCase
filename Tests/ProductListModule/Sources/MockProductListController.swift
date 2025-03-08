//
//  MockProductListController.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

@testable import ProductList

final class MockProductListController: ProductListViewInterface {
    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedReloadCollectionView = false
    var invokedReloadCollectionViewCount = 0

    func reloadCollectionView() {
        invokedReloadCollectionView = true
        invokedReloadCollectionViewCount += 1
    }
}
