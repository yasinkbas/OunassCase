//
//  ProductListTransitioningDelegate.swift
//  OunassCase
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit

final class ProductListTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    private let selectedCellFrame: CGRect
    private let selectedImageView: UIImageView

    init(selectedCellFrame: CGRect, selectedImageView: UIImageView) {
        self.selectedCellFrame = selectedCellFrame
        self.selectedImageView = selectedImageView
        super.init()
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ProductListToDetailTransition(selectedCellFrame: selectedCellFrame, selectedImageView: selectedImageView, isPresenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ProductListToDetailTransition(selectedCellFrame: selectedCellFrame, selectedImageView: selectedImageView, isPresenting: false)
    }
}
