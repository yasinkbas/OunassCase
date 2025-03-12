//
//  ProductDetailSizeSelectionPresenter.swift
//  ProductDetailModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import Foundation
import CommonKit

protocol ProductDetailSizeSelectionPresenterInterface: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func size(at indexPath: IndexPath) -> String
    func didSelectSize(at indexPath: IndexPath)
}

struct ProductDetailSizeSelectionArguments {
    let sizes: [String]
}

protocol ProductDetailSizeSelectionDelegate: AnyObject {
    func didSelectSize(_ size: String)
}

protocol ProductDetailSizeSelectionModule {
    var selectedSize: String? { get }
}

class ProductDetailSizeSelectionPresenter {
    private weak var view: ProductDetailSizeSelectionViewInterface?
    private let router: ProductDetailSizeSelectionRouter
    private weak var delegate: ProductDetailSizeSelectionDelegate?
    
    private var arguments: ProductDetailSizeSelectionArguments
    private(set) var selectedSize: String?

    init(
        view: ProductDetailSizeSelectionViewInterface,
        router: ProductDetailSizeSelectionRouter,
        delegate: ProductDetailSizeSelectionDelegate,
        arguments: ProductDetailSizeSelectionArguments
    ) {
        self.view = view
        self.router = router
        self.delegate = delegate
        self.arguments = arguments
    }
}

// MARK: - ProductDetailSizeSelectionPresenterInterface
extension ProductDetailSizeSelectionPresenter: ProductDetailSizeSelectionPresenterInterface {
    func viewDidLoad() {
        selectedSize = arguments.sizes.first
        
        view?.prepareUI()
        view?.reloadData()
    }
    
    func numberOfItems() -> Int {
        arguments.sizes.count
    }
    
    func size(at indexPath: IndexPath) -> String {
        arguments.sizes[indexPath.item]
    }
    
    func didSelectSize(at indexPath: IndexPath) {
        guard let size = arguments.sizes[safe: indexPath.item] else { return }
        selectedSize = size
        delegate?.didSelectSize(size)
    }
}

// MARK: - ProductDetailSizeSelectionModule
extension ProductDetailSizeSelectionPresenter: ProductDetailSizeSelectionModule {}
