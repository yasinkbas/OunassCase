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
    
    func viewDidLoad() async
    func viewWillAppear()
    func didTapBackButton()
    func didTapAddToCartButton()
    func didTapBasketButton()
}

struct ProductDetailArguments {
    let slug: String
    let image: String
}

final class ProductDetailPresenter {
    private weak var view: ProductDetailViewInterface?
    private let router: ProductDetailRouterInterface
    private let interactor: ProductDetailInteractorInterface
    private let arguments: ProductDetailArguments
    private let basketManager: BasketManagerInterface
    private var productDetailResponse: ProductDetailResponse?
    
    private var sizeSelectionModule: ProductDetailSizeSelectionModule?
    private var imageSliderModule: ProductDetailImageSliderModule?
    
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
        guard var sizes = productDetailResponse?.sizeGuide?.columns?.first else { return }
        sizes.removeFirst() // remove first item like generic/uk etc
        let arguments = ProductDetailSizeSelectionArguments(sizes: sizes)
        sizeSelectionModule = view?.prepareProductDetailSizeSelectionView(arguments: arguments)
    }
    
    private func prepareImageSliderItems() {
//        guard let media = productDetailResponse?.media else { return }
//        let imageUrls = media.compactMap(\.src).map { "https://ounass-ae.atgcdn.ae/small_light(dw=120,of=webp)/pub/media/catalog/\($0)" }
        let imageUrls = ["https:\(arguments.image)"]
        let arguments = ProductDetailImageSliderArguments(imageUrls: imageUrls)
        imageSliderModule = view?.prepareProductDetailImageSliderView(arguments: arguments)
    }
    
    private func updateAddToBasketButtonState() {
        guard let productId = productDetailResponse?.styleColorID,
              let selectedSize = sizeSelectionModule?.selectedSize else { return }
        
        if basketManager.isInBasket(productId: productId, size: selectedSize) {
            view?.updateAddToBasketButton(for: .unaddable)
        } else {
            view?.updateAddToBasketButton(for: .addable)
        }
    }
}

// MARK: - ProductDetailPresenterInterface
extension ProductDetailPresenter: ProductDetailPresenterInterface {
    var productDetailSizeSelectionDelegate: ProductDetailSizeSelectionDelegate { self }
    
    @MainActor
    func viewDidLoad() async {
        view?.prepareUI()
        
        view?.showLoading()
        await fetchDetail(slug: arguments.slug)
        view?.hideLoading()
        
        prepareSizeSelectionItems()
        prepareImageSliderItems()
        updateAddToBasketButtonState()
        
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
    
    func viewWillAppear() {
        view?.prepareNavigationBar()
    }
    
    func didTapBackButton() {
        router.dismiss()
    }
    
    func didTapAddToCartButton() {
        guard let productId = productDetailResponse?.styleColorID,
              let name = productDetailResponse?.name,
              let selectedSize = sizeSelectionModule?.selectedSize else { return }
        let product = AddToBasketProduct(id: productId, name: name, size: selectedSize)
        if basketManager.isInBasket(productId: productId, size: selectedSize) {
            basketManager.removeProduct(with: productId, size: selectedSize)
        } else {
            basketManager.addProduct(product)
        }
        
        updateAddToBasketButtonState()
    }
    
    func didTapBasketButton() {
        router.routeToBasket()
    }
}

// MARK: - ProductDetailInteractorOutput
extension ProductDetailPresenter: ProductDetailInteractorOutput {
    func handleRequestError(error: any Error) {
        view?.showAlert(message: error.localizedDescription)
    }
}

// MARK: - ProductDetailSizeSelectionDelegate
extension ProductDetailPresenter: ProductDetailSizeSelectionDelegate {
    func productDetailSizeSelectionDidSelectSize(_ size: String) {
        updateAddToBasketButtonState()
    }
}
