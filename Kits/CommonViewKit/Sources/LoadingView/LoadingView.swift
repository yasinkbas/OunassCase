//
//  LoadingView.swift
//  OunassCase
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit
import UILab
import CommonKit

public protocol LoadingViewInterface: AnyObject {
    func prepareUI()
}

private extension LoadingView {
    enum Constants {
        static let backgroundColor: UIColor = UIColor.gray
        static let activityColor: UIColor = UIColor.white
        static let cornerRadius: CGFloat = 16
    }
}

public class LoadingView: UIView {
    var presenter: LoadingPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator: UIActivityIndicatorView
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = Constants.activityColor
        return activityIndicator
    }()
}

// MARK: - LoadingViewInterface
extension LoadingView: LoadingViewInterface {
    public func prepareUI() {
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(activityIndicator)
        activityIndicator.set(.center(self))
        activityIndicator.startAnimating()
    }
}
