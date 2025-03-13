//
//  LoadingViewPresenter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 13.03.2025.
//

import Foundation

public protocol LoadingPresenterInterface: AnyObject {
    func load()
}

public class LoadingPresenter {
    private weak var view: LoadingViewInterface?

    public init(view: LoadingViewInterface) {
        self.view = view
    }
}

// MARK: - LoadingPresenterInterface
extension LoadingPresenter: LoadingPresenterInterface {
    public func load() {
        view?.prepareUI()
    }
}
