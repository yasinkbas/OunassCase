//
//  ProductCell.swift
//  OunassCase
//
//  Created by Yasin Akbas on 7.03.2025.
//

import UIKit
import UILab
import SDWebImage

private extension ProductCell {
    enum Constants {
        enum NameLabel {
            static let font = UIFont.systemFont(ofSize: 14, weight: .medium)
            static let numberOfLines = 2
        }
        
        enum StackView {
            static let spacing: CGFloat = 8
        }
        
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let borderColor: UIColor = UIColor.lightGray
    }
}

struct ProductCellArguments {
    let productName: String?
    let thumbnailImage: String?
}

final class ProductCell: UICollectionViewCell {    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.NameLabel.font
        label.numberOfLines = Constants.NameLabel.numberOfLines
        return label
    }()
    
    lazy var containerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.StackView.spacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        contentView.backgroundColor = Constants.backgroundColor
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = Constants.borderColor.cgColor
        contentView.layer.masksToBounds = true
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        
        containerView.set(
            .topOf(contentView, 8),
            .leadingOf(contentView, 8),
            .trailingOf(contentView, 8),
            .bottomOf(contentView, 8)
        )
        imageView.set(
            .height(200),
            .width(150)
        )
    }

    func configure(with arguments: ProductCellArguments) {
        nameLabel.text = arguments.productName
        
        if let imageUrl = arguments.thumbnailImage {
            imageView.loadImage(from: imageUrl)
        }
    }
}
