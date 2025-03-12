//
//  UIViewController+Extensions.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import UILab

public extension UIViewController {
    func embed(_ viewController: UIViewController, in view: UIView){
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.view.set(.leadingOf(view), .trailingOf(view), .topOf(view), .bottomOf(view))
        addChild(viewController)
        viewController.didMove(toParent: self)
    }
}
