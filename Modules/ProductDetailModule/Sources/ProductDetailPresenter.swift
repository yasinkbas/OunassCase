//
//  ProductDetailPresenter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import Foundation
import DependencyManagerKit
import BasketManagerKit

protocol ProductDetailPresenterInterface: AnyObject {
    var productDetailSizeSelectionDelegate: ProductDetailSizeSelectionDelegate { get }
    
    @MainActor func viewDidLoad() async
    func didTapBackButton()
    func didTapAddToCartButton()
    func didTapBasketButton()
}

struct ProductDetailArguments {
    let slug: String
    let image: String
}

class ProductDetailPresenter {
    private weak var view: ProductDetailViewInterface?
    private let router: ProductDetailRouterInterface
    private let interactor: ProductDetailInteractorInterface
    private let arguments: ProductDetailArguments
    private let basketManager: BasketManagerInterface
    private var productDetailResponse: ProductDetailResponse?
    
    private var sizeSelectionModule: ProductDetailSizeSelectionModule?

    init(
        view: ProductDetailViewInterface,
        router: ProductDetailRouterInterface,
        interactor: ProductDetailInteractorInterface,
        arguments: ProductDetailArguments,
        basketManager: BasketManagerInterface = BasketManager.shared
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.arguments = arguments
        self.basketManager = basketManager
    }
    
    private func fetchDetail(slug: String) async {
        let data = await interactor.fetchProductDetail(slug: slug)
        productDetailResponse = data?.pdpResult
    }
    
    private func prepareSizeSelectionItems() {
        guard let sizes = productDetailResponse?.sizeGuide?.columns?.first else { return }
        let arguments = ProductDetailSizeSelectionArguments(sizes: sizes)
        sizeSelectionModule = view?.prepareProductDetailSizeSelectionView(arguments: arguments)
    }
}

// MARK: - ProductDetailPresenterInterface
extension ProductDetailPresenter: ProductDetailPresenterInterface {
    var productDetailSizeSelectionDelegate: ProductDetailSizeSelectionDelegate { self }
    
    @MainActor func viewDidLoad() async {
        view?.prepareUI()
        view?.setImageView(imageUrl: "https:\(arguments.image)")
        
        await fetchDetail(slug: arguments.slug)
        prepareSizeSelectionItems()
        
        if let productName = productDetailResponse?.name {
            view?.setProductNameLabel(text: productName)
        }
        if let price = productDetailResponse?.price {
            view?.setPriceLabel(text: String(price))
        }
        if let description = productDetailResponse?.descriptionText {
            view?.setDescriptionLabel(text: description)
        }
    }
    
    func didTapBackButton() {
        router.dismiss()
    }
    
    func didTapAddToCartButton() {
        guard let productId = productDetailResponse?.styleColorID,
                let name = productDetailResponse?.name,
                let selectedSize = sizeSelectionModule?.selectedSize else { return }
        let product = AddToBasketProduct(id: productId, name: name, size: selectedSize)
        basketManager.addProduct(product)
    }
    
    func didTapBasketButton() {
        router.routeToBasket()
    }
}

// MARK: - ProductDetailInteractorOutput
extension ProductDetailPresenter: ProductDetailInteractorOutput { 
    func handleRequestError(error: any Error) {
        print("--> error \(error)")
    }
}

extension ProductDetailPresenter: ProductDetailSizeSelectionDelegate {
    func didSelectSize(_ size: String) {
        
    }
}
