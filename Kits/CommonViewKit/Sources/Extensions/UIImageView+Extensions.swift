//
//  UIImageView+Extensions.swift
//  OunassCase
//
//  Created by Yasin Akbas on 11.03.2025.
//

import UIKit
import SDWebImage

public extension UIImageView {
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        sd_setImage(with: url) { [weak self] image, _, _, _ in
            guard let self else { return }
            self.image = image
        }
    }
}
