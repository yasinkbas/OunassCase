//
//  ProductDetailSizeCell.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import UILab

private extension ProductDetailSizeCell {
    enum Constants {
        static let sizeLabelFont: UIFont = .boldSystemFont(ofSize: 16)
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 2
        static let borderColor: UIColor = .darkGray
        static let backgroundColor: UIColor = .clear
    }
}

final class ProductDetailSizeCell: UICollectionViewCell {
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.sizeLabelFont
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? .systemGreen : .clear
            sizeLabel.textColor = isSelected ? .white : .label
            contentView.layer.borderColor = isSelected ? UIColor.systemGreen.cgColor : UIColor.darkGray.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.borderWidth = Constants.borderWidth
        contentView.layer.borderColor = Constants.borderColor.cgColor
        contentView.backgroundColor =  Constants.backgroundColor
    }
    
    private func prepareUI() {
        contentView.addSubview(sizeLabel)
        sizeLabel.set(
            .topOf(contentView),
            .bottomOf(contentView),
            .leadingOf(contentView),
            .trailingOf(contentView)
        )
    }
    
    func configure(with size: String) {
        sizeLabel.text = size
    }
}
