//
//  LoadingShowable.swift
//  OunassCase
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit

public protocol LoadingShowable: AnyObject {
    func showLoading()
    func hideLoading()
}

public extension LoadingShowable where Self: UIViewController {
    func showLoading() {
        let loadingView = LoadingView()
        let presenter = LoadingPresenter(view: loadingView)
        loadingView.presenter = presenter

        view.addSubview(loadingView)
        loadingView.set(.center(view), .width(100), .height(100))
    }
    
    func hideLoading() {
        for view in view.subviews where view is LoadingView {
            view.removeFromSuperview()
        }
    }
}
