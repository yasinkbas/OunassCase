//
//  ProductListPresenter.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import Foundation
import CommonKit

protocol ProductListPresenterInterface: AnyObject {
    func viewDidLoad() async
    func didPullToRefresh() async
    func numberOfItemsInSection() -> Int
    func productCellArguments(for indexPath: IndexPath) -> ProductCellArguments?
    func collectionViewDidSelectItem(indexPath: IndexPath)
    func collectionViewWillDisplay(indexPath: IndexPath) async
    func collectionViewSizeForItemAt(viewWidth: Double) -> (width: Double, height: Double)
}

private extension ProductListPresenter {
    enum Constants {
        static let potraitItemsPerRow: Double = 2
        static let landscapeItemsPerRow: Double = 4
        static let horizontalPadding: Double = 16
        static let heightRatio: Double = 1.6
    }
}

final class ProductListPresenter {
    private weak var view: ProductListViewInterface?
    private let router: ProductListRouterInterface
    private let interactor: ProductListInteractorInterface
    private let deviceChecker: DeviceCheckerInterface
    
    private var productList: [StyleColor] = []
    private var pagination: Pagination?
    
    init(view: ProductListViewInterface,
         router: ProductListRouterInterface,
         interactor: ProductListInteractorInterface,
         deviceChecker: DeviceCheckerInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.deviceChecker = deviceChecker
    }
    
    private func checkListEmpty() {
        productList.isEmpty
        ? view?.showEmptyView()
        : view?.hideEmptyView()
    }
    
    @MainActor
    private func fetchProducts(for pageHref: String?) async {
        var startIndex: Int = .zero
        if let pageHref {
            startIndex = interactor.getStartIndex(for: pageHref)
        }
        view?.showLoading()
        let data = await interactor.fetchProducts(for: startIndex)
        view?.hideLoading()
        pagination = data?.plpResult?.pagination
        productList.append(contentsOf: data?.plpResult?.styleColors ?? [])
    }
}

// MARK: - ProductListPresenterInterface
extension ProductListPresenter: ProductListPresenterInterface {
    @MainActor
    func viewDidLoad() async {
        view?.prepareUI()
        await fetchProducts(for: nil)
        checkListEmpty()
        view?.reloadCollectionView()
    }
    
    @MainActor
    func didPullToRefresh() async {
        view?.startRefreshing()
        productList.removeAll(keepingCapacity: true)
        await fetchProducts(for: nil)
        checkListEmpty()
        view?.stopRefreshing()
        view?.reloadCollectionView()
    }
    
    func numberOfItemsInSection() -> Int {
        productList.count
    }
    
    func productCellArguments(for indexPath: IndexPath) -> ProductCellArguments? {
        guard let product = productList[safe: indexPath.item] else { return nil }
        return .init(productName: product.name, thumbnailImage: "https:\(product.thumbnail ?? "")")
    }
    
    func collectionViewDidSelectItem(indexPath: IndexPath) {
        guard let product = productList[safe: indexPath.item], let image = product.thumbnail, let slug = product.slug else { return }
        router.routeToDetail(detailArguments: .init(imageUrl: image, slug: slug))
    }
    
    func collectionViewWillDisplay(indexPath: IndexPath) async {
        if let nextPageHref = pagination?.nextPage?.href,
        indexPath.item == productList.count - 1 {
            await fetchProducts(for: nextPageHref)
            view?.reloadCollectionView()
        }
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
        view?.showAlert(message: error.localizedDescription)
    }
}
