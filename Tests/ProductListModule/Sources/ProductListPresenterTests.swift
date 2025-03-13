//
//  ProductListPresenterTests.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

import XCTest
@testable import ProductListModule
import CommonKit
import NetworkManagerKit

final class ProductListPresenterTests: XCTestCase {
    var view: MockProductListController!
    var interactor: MockProductListInteractor!
    var presenter: ProductListPresenter!
    var router: MockProductListRouter!
    var deviceChecker: MockDeviceChecker!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        deviceChecker = .init()
        presenter = .init(view: view, router: router, interactor: interactor, deviceChecker: deviceChecker)
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() async {
        await presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedShowLoading)
        XCTAssertTrue(interactor.invokedFetchProducts)
        XCTAssertEqual(interactor.invokedFetchProductsParameters?.startIndex, 0)
        XCTAssertTrue(view.invokedHideLoading)
        XCTAssertTrue(view.invokedReloadCollectionView)
    }
    
    func test_viewDidLoad_EmptyList_InvokesRequiredMethods() async {
        interactor.stubbedFetchProductsResponse = productListEmptyResponse
        await presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedShowLoading)
        XCTAssertTrue(interactor.invokedFetchProducts)
        XCTAssertEqual(interactor.invokedFetchProductsParameters?.startIndex, 0)
        XCTAssertTrue(view.invokedHideLoading)
        XCTAssertTrue(view.invokedReloadCollectionView)
        XCTAssertTrue(view.invokedShowEmptyView)
    }
    
    func test_viewDidLoad_FilledList_InvokesRequiredMethods() async {
        interactor.stubbedFetchProductsResponse = productListFullResponse
        await presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(view.invokedShowLoading)
        XCTAssertTrue(interactor.invokedFetchProducts)
        XCTAssertEqual(interactor.invokedFetchProductsParameters?.startIndex, 0)
        XCTAssertTrue(view.invokedHideLoading)
        XCTAssertTrue(view.invokedReloadCollectionView)
        XCTAssertFalse(view.invokedShowEmptyView)
    }
    
    func test_didPullToRefresh_InvokesRequiredMethods() async {
        await presenter.didPullToRefresh()
        
        XCTAssertTrue(view.invokedStartRefreshing)
        XCTAssertTrue(view.invokedShowLoading)
        XCTAssertTrue(interactor.invokedFetchProducts)
        XCTAssertTrue(view.invokedHideLoading)
        XCTAssertTrue(view.invokedReloadCollectionView)
        XCTAssertTrue(view.invokedStopRefreshing)
    }
    
    func test_numberOfItemsInSection_NoProducts_ReturnsZero() async {
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
        
        interactor.stubbedFetchProductsResponse = productListEmptyResponse
        await presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
    }
    
    func test_numberOfItemsInSection_ProductsExist_ReturnsValidCount() async {
        XCTAssertEqual(presenter.numberOfItemsInSection(), 0)
        
        interactor.stubbedFetchProductsResponse = productListFullResponse
        await presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.numberOfItemsInSection(), 48)
    }
    
    func test_productCellArguments_ReturnsValidValues() async {
        interactor.stubbedFetchProductsResponse = productListFullResponse
        await presenter.viewDidLoad()
        
        let indexPath = IndexPath(item: 0, section: 0)
        let productCellArguments = presenter.productCellArguments(for: indexPath)
        
        XCTAssertEqual(productCellArguments?.productName, "Floral Off-shoulder Gown in Tulle")
        XCTAssertEqual(productCellArguments?.thumbnailImage, "https://ounass-ae.atgcdn.ae/small_light(dw=350,of=webp)/pub/media/catalog/product/2/1/217745930_cream_in.jpg?ts=1733935041.8102")
    }
 
    func test_collectionViewDidSelectItem_InvokesRequiredMethods() async {
        interactor.stubbedFetchProductsResponse = productListFullResponse
        await presenter.viewDidLoad()
        
        XCTAssertFalse(router.invokedRouteToDetail)
        
        presenter.collectionViewDidSelectItem(indexPath: .init(item: .zero, section: .zero))
        
        XCTAssertEqual(router.invokedRouteToDetailParameters?.detailArguments.imageUrl, "//ounass-ae.atgcdn.ae/small_light(dw=350,of=webp)/pub/media/catalog/product/2/1/217745930_cream_in.jpg?ts=1733935041.8102")
        XCTAssertEqual(router.invokedRouteToDetailParameters?.detailArguments.slug, "shop-needle-thread-floral-off-shoulder-gown-in-tulle-for-women-217745930_185")
    }

    func test_collectionViewWillDisplay_PaginationNextPageHrefNotExist_DoesNotInvokeFetchProducts() async {
        XCTAssertEqual(interactor.invokedFetchProductsCount, 0)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 0)
        
        interactor.stubbedFetchProductsResponse = productListLastPageResponse
        await presenter.viewDidLoad()
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 1)
        
        await presenter.collectionViewWillDisplay(indexPath: .init(item: 47, section: 0))
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 1)
    }
    
    func test_collectionViewWillDisplay_ItemIsNotLastItemInSection_DoesNotInvokeFetchProducts() async {
        XCTAssertEqual(interactor.invokedFetchProductsCount, 0)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 0)
        
        interactor.stubbedFetchProductsResponse = productListLastPageResponse
        await presenter.viewDidLoad()
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 1)
        
        await presenter.collectionViewWillDisplay(indexPath: .init(item: 0, section: 0))
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 1)
    }
    
    func test_collectionViewWillDisplay_PaginationNextPageHrefExist_InvokesFetchProducts() async {
        XCTAssertEqual(interactor.invokedFetchProductsCount, 0)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 0)
        
        interactor.stubbedFetchProductsResponse = productListFullResponse
        await presenter.viewDidLoad()
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 1)
        
        await presenter.collectionViewWillDisplay(indexPath: .init(item: 47, section: 0))
        
        XCTAssertEqual(interactor.invokedFetchProductsCount, 2)
        XCTAssertEqual(view.invokedReloadCollectionViewCount, 2)
    }
    
    func test_collectionViewSizeForItemAt_Potrait_ReturnsCorrectValue() {
        deviceChecker.stubbedIsPotrait = true
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 200).height, 121.6, accuracy: 0.01)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 200).width, 76)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 400).height, 281.6, accuracy: 0.01)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 400).width, 176)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 600).height, 441.6, accuracy: 0.01)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 600).width, 276)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 800).height, 601.6, accuracy: 0.01)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 800).width, 376)
    }
    
    func test_collectionViewSizeForItemAt_Landscape_ReturnsCorrectValue() {
        deviceChecker.stubbedIsPotrait = false
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 200).height, 48)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 200).width, 30)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 400).height, 128)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 400).width, 80)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 600).height, 208)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 600).width, 130)
        
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 800).height, 288)
        XCTAssertEqual(presenter.collectionViewSizeForItemAt(viewWidth: 800).width, 180)
    }
    
    func test_handleRequestError_InvokesRequiredMethods() {
        presenter.handleRequestError(error: TestError.networkError)
        
        XCTAssertTrue(view.invokedShowAlert)
    }
}

extension ProductListPresenterTests {
    var bundle: Bundle { .init(for: Self.self) }
    
    enum TestError: Error {
        case networkError
    }
    
    var productListEmptyResponse: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>? {
        JSONParser.decode(for: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>?.self,
                          fileName: "ProductListEmptyResponse",
                          bundle: bundle)
    }
    
    var productListFullResponse: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>? {
        JSONParser.decode(for: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>?.self,
                          fileName: "ProductListFullResponse",
                          bundle: bundle)
    }
    
    var productListLastPageResponse: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>? {
        JSONParser.decode(for: NetworkManagerKit.ProductListBaseAPIResponse<ProductListResponse>?.self,
                          fileName: "ProductListLastPageResponse",
                          bundle: bundle)
    }
}
