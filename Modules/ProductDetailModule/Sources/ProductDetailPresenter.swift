//
//  ProductDetailPresenter.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import Foundation
import DependencyManagerKit

protocol ProductDetailPresenterInterface: AnyObject {
    @MainActor func viewDidLoad() async
    func didTapBackButton()
    func didTapAddToCartButton()
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
    private var productDetailResponse: ProductDetailResponse?
    @Dependency private var productListModule: ProductListModuleInterface?

    init(
        view: ProductDetailViewInterface,
        router: ProductDetailRouterInterface,
        interactor: ProductDetailInteractorInterface,
        arguments: ProductDetailArguments
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.arguments = arguments
    }
    
    private func fetchDetail(slug: String) async {
        let data = await interactor.fetchProductDetail(slug: slug)
        productDetailResponse = data?.pdpResult
    }
}

// MARK: - ProductDetailPresenterInterface
extension ProductDetailPresenter: ProductDetailPresenterInterface {
    @MainActor func viewDidLoad() async {
        view?.prepareUI()
        view?.setImageView(imageUrl: "https:\(arguments.image)")
        
        await fetchDetail(slug: arguments.slug)
        
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
        // basketManagerKit
        // basketModule
    }
}

// MARK: - ProductDetailInteractorOutput
extension ProductDetailPresenter: ProductDetailInteractorOutput { 
    func handleRequestError(error: any Error) {
        print("--> error \(error)")
    }
}
