//
//  ProductDetailModuleInterface.swift
//  OunassCase
//
//  Created by Yasin Akbas on 4.03.2025.
//

import UIKit

public struct ProductDetailModuleArguments {
    public let imageUrl: String
    public let slug: String
    
    public init(imageUrl: String, slug: String) {
        self.imageUrl = imageUrl
        self.slug = slug
    }
}

public protocol ProductDetailModuleInterface: AnyObject {
    func productDetailViewController(using navigationController: UINavigationController, arguments: ProductDetailModuleArguments) -> UIViewController
}
