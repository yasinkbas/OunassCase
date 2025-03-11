//
//  ProductListToDetailTransition.swift
//  OunassCase
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit

struct ProductListToDetailTransitionArguments {
    let selectedCellFrame: CGRect
    let selectedImageView: UIImageView
}

final class ProductListToDetailTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let selectedCellFrame: CGRect
    private let selectedImageView: UIImageView
    private let isPresenting: Bool

    init(selectedCellFrame: CGRect, selectedImageView: UIImageView, isPresenting: Bool) {
        self.selectedCellFrame = selectedCellFrame
        self.selectedImageView = selectedImageView
        self.isPresenting = isPresenting
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to)
        else { return }

        let containerView = transitionContext.containerView

        if isPresenting {
            presentAnimation(transitionContext: transitionContext, containerView: containerView, toView: toView)
        } else {
            dismissAnimation(transitionContext: transitionContext, containerView: containerView, fromView: fromView)
        }
    }

    private func presentAnimation(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, toView: UIView) {
        let imageViewCopy = UIImageView(image: selectedImageView.image)
        imageViewCopy.contentMode = selectedImageView.contentMode
        imageViewCopy.clipsToBounds = true
        imageViewCopy.frame = selectedCellFrame
        
        toView.alpha = 0
        containerView.addSubview(toView)
        containerView.addSubview(imageViewCopy)

        let leftInset = 0.0
        let topInset = containerView.safeAreaInsets.top + 60
        let targetHeight = containerView.bounds.height / 3 * 2
        let targetWidth = containerView.bounds.width

        let targetFrame = CGRect(
            x: leftInset,
            y: topInset,
            width: targetWidth,
            height: targetHeight
        )

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageViewCopy.frame = targetFrame
            toView.alpha = 1
        }) { _ in
            imageViewCopy.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }

    private func dismissAnimation(
        transitionContext: UIViewControllerContextTransitioning,
        containerView: UIView,
        fromView: UIView
    ) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }

        containerView.insertSubview(toView, belowSubview: fromView)

        let imageViewCopy = UIImageView(image: selectedImageView.image)
        imageViewCopy.contentMode = selectedImageView.contentMode
        imageViewCopy.clipsToBounds = true
        imageViewCopy.frame = fromView.frame
        containerView.addSubview(imageViewCopy)

        let finalFrame = selectedCellFrame

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                imageViewCopy.frame = finalFrame
                fromView.alpha = 0
                toView.alpha = 1
            },
            completion: { _ in
                imageViewCopy.removeFromSuperview()
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        )
    }
}
