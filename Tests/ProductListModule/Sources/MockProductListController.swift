//
//  MockProductListController.swift
//  OunassCase
//
//  Created by Yasin Akbas on 8.03.2025.
//

import UIKit
import CommonViewKit
@testable import ProductListModule

final class MockProductListController: ProductListViewInterface {

    var invokedEmptyViewArgumentsGetter = false
    var invokedEmptyViewArgumentsGetterCount = 0
    var stubbedEmptyViewArguments: EmptyViewPresenterArguments!

    var emptyViewArguments: EmptyViewPresenterArguments {
        invokedEmptyViewArgumentsGetter = true
        invokedEmptyViewArgumentsGetterCount += 1
        return stubbedEmptyViewArguments
    }

    var invokedEmptyViewContainerViewGetter = false
    var invokedEmptyViewContainerViewGetterCount = 0
    var stubbedEmptyViewContainerView: UIView!

    var emptyViewContainerView: UIView {
        invokedEmptyViewContainerViewGetter = true
        invokedEmptyViewContainerViewGetterCount += 1
        return stubbedEmptyViewContainerView
    }

    var invokedEmptyViewPaddingsGetter = false
    var invokedEmptyViewPaddingsGetterCount = 0
    var stubbedEmptyViewPaddings: UIEdgeInsets!

    var emptyViewPaddings: UIEdgeInsets {
        invokedEmptyViewPaddingsGetter = true
        invokedEmptyViewPaddingsGetterCount += 1
        return stubbedEmptyViewPaddings
    }

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

    var invokedStartRefreshing = false
    var invokedStartRefreshingCount = 0

    func startRefreshing() {
        invokedStartRefreshing = true
        invokedStartRefreshingCount += 1
    }

    var invokedStopRefreshing = false
    var invokedStopRefreshingCount = 0

    func stopRefreshing() {
        invokedStopRefreshing = true
        invokedStopRefreshingCount += 1
    }

    var invokedShowAlert = false
    var invokedShowAlertCount = 0
    var invokedShowAlertParameters: (message: String, Void)?
    var invokedShowAlertParametersList = [(message: String, Void)]()

    func showAlert(message: String) {
        invokedShowAlert = true
        invokedShowAlertCount += 1
        invokedShowAlertParameters = (message, ())
        invokedShowAlertParametersList.append((message, ()))
    }

    var invokedShowLoading = false
    var invokedShowLoadingCount = 0

    func showLoading() {
        invokedShowLoading = true
        invokedShowLoadingCount += 1
    }

    var invokedHideLoading = false
    var invokedHideLoadingCount = 0

    func hideLoading() {
        invokedHideLoading = true
        invokedHideLoadingCount += 1
    }

    var invokedShowEmptyView = false
    var invokedShowEmptyViewCount = 0

    func showEmptyView() {
        invokedShowEmptyView = true
        invokedShowEmptyViewCount += 1
    }

    var invokedHideEmptyView = false
    var invokedHideEmptyViewCount = 0

    func hideEmptyView() {
        invokedHideEmptyView = true
        invokedHideEmptyViewCount += 1
    }
}
