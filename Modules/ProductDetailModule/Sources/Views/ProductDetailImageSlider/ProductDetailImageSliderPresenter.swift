//
//  ProductDetailImageSliderPresenter.swift
//  ProductDetailModule
//
//  Created by Yasin Akbas on 13.03.2025.
//

import Foundation

protocol ProductDetailImageSliderPresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfImages() -> Int
    func imageUrl(at indexPath: IndexPath) -> String
}

struct ProductDetailImageSliderArguments {
    var imageUrls: [String]
}

protocol ProductDetailImageSliderModule: AnyObject {
    func updateImages(imageUrls: [String])
}

final class ProductDetailImageSliderPresenter {
    private weak var view: ProductDetailImageSliderViewInterface?
    private let router: ProductDetailImageSliderRouterInterface
    private var arguments: ProductDetailImageSliderArguments

    init(
        view: ProductDetailImageSliderViewInterface,
        router: ProductDetailImageSliderRouterInterface,
        arguments: ProductDetailImageSliderArguments
    ) {
        self.view = view
        self.router = router
        self.arguments = arguments
    }
}

// MARK: - ProductDetailImageSliderPresenterInterface
extension ProductDetailImageSliderPresenter: ProductDetailImageSliderPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        view?.reloadData()
    }
    
    func numberOfImages() -> Int {
        arguments.imageUrls.count
    }

    func imageUrl(at indexPath: IndexPath) -> String {
        arguments.imageUrls[indexPath.item]
    }
}

// MARK: - ProductDetailImageSliderModule
extension ProductDetailImageSliderPresenter: ProductDetailImageSliderModule {
    func updateImages(imageUrls: [String]) {
        self.arguments.imageUrls = imageUrls
        view?.reloadData()
    }
}
