//
//  ProductDetailImageCell.swift
//  OunassCase
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit
import UILab
import SDWebImage

final class ProductDetailImageCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.set(
            .topOf(contentView),
            .bottomOf(contentView),
            .leadingOf(contentView),
            .trailingOf(contentView)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageUrl: String) {
        imageView.loadImage(from: imageUrl)
    }
}
