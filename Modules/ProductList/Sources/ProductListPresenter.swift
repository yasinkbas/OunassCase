//
//  ProductListPresenter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation
import protocol CommonKit.DeviceCheckerInterface

protocol ProductListPresenterInterface: AnyObject {
    func viewDidLoad() async
    func numberOfItemsInSection() -> Int
    func productCellArguments(for indexPath: IndexPath) -> ProductCellArguments
    func collectionViewDidSelectItem(indexPath: IndexPath)
    func collectionViewWillDisplay(indexPath: IndexPath)
    func collectionViewSizeForItemAt(viewWidth: Double) -> (width: Double, height: Double)
}

private extension ProductListPresenter {
    enum Constants {
        static let potraitItemsPerRow: Double = 2
        static let landscapeItemsPerRow: Double = 4
        static let horizontalPadding: Double = 16
        static let heightRatio: Double = 1.6
        static let initialPageNumber: Int = 1
    }
}

final class ProductListPresenter: @unchecked Sendable {
    private weak var view: ProductListViewInterface?
    private let router: ProductListRouterInterface
    private let interactor: ProductListInteractorInterface
    private let deviceChecker: DeviceCheckerInterface
    
    private var productList: [StyleColor] = []
    private var pagination: Pagination?
    private var isFetching = false
    private var pageNumber: Int = 1
    
    init(view: ProductListViewInterface,
         router: ProductListRouterInterface,
         interactor: ProductListInteractorInterface,
         deviceChecker: DeviceCheckerInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.deviceChecker = deviceChecker
    }
}

// MARK: - ProductListPresenterInterface
extension ProductListPresenter: ProductListPresenterInterface {
    @MainActor func viewDidLoad() async {
        view?.prepareUI()
        let data = await interactor.fetchProducts()
        productList = data?.result?.styleColors ?? []
        
        DispatchQueue.main.async {
            self.view?.reloadCollectionView()
        }
    }
    
    func numberOfItemsInSection() -> Int {
        productList.count
    }
    
    func productCellArguments(for indexPath: IndexPath) -> ProductCellArguments {
        let product = productList[indexPath.item]
        return .init(productName: product.name, thumbnailImage: product.thumbnail)
    }
    
    func collectionViewDidSelectItem(indexPath: IndexPath) {
        // TODO: move detail
    }
    
    func collectionViewWillDisplay(indexPath: IndexPath) {
        // TODO: pagination
    }
    
    func collectionViewSizeForItemAt(viewWidth: Double) -> (width: Double, height: Double) {
        let itemsPerRow: Double = deviceChecker.isPotrait
        ? Constants.potraitItemsPerRow
        : Constants.landscapeItemsPerRow
        let padding: Double = Constants.horizontalPadding
        let totalSpacing = padding * (itemsPerRow - 1)
        let availableWidth = viewWidth - (padding * 2) - totalSpacing
        let itemWidth = availableWidth / itemsPerRow
        return (width: itemWidth, height: itemWidth * Constants.heightRatio)
    }
}

// MARK: - ProductListInteractorOutput
extension ProductListPresenter: ProductListInteractorOutput {
    func handleRequestError(error: any Error) {
        print("--> error \(error)")
    }
}
