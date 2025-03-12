//
//  ProductDetailSizeCell.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import UILab

final class ProductDetailSizeCell: UICollectionViewCell {
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
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
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.backgroundColor = .clear
    }
    
    private func prepareUI() {
        contentView.addSubview(sizeLabel)
        sizeLabel.set(.topOf(contentView), .bottomOf(contentView), .leadingOf(contentView), .trailingOf(contentView))
    }
    
    func configure(with size: String) {
        sizeLabel.text = size
    }
}
