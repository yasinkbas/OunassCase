//
//  ProductDetailViewController.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit
import UILab
import CommonViewKit

protocol ProductDetailViewInterface: AnyObject {
    func prepareUI()
    func setImageView(imageUrl: String)
    func setProductNameLabel(text: String)
    func setPriceLabel(text: String)
    func setDescriptionLabel(text: String)
}

class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenterInterface!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .systemGreen
        label.isHidden = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.isHidden = true
        return label
    }()
    
    private lazy var addToBagButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.setTitle("Add to Bag", for: .normal)
        button.addTarget(self, action: #selector(didTapAddToBag), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("← Back", for: .normal)
        button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task {
            await presenter.viewDidLoad()
        }
    }
    
    @objc private func didTapAddToBag() {
        presenter.didTapAddToCartButton()
    }
    
    @objc private func didTapBack() {
        presenter.didTapBackButton()
    }
}

// MARK: - ProductDetailViewInterface
extension ProductDetailViewController: ProductDetailViewInterface {
    func prepareUI() {
        view.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(addToBagButton)
        
        backButton.set(
            .top(view.safeAreaLayoutGuide.topAnchor),
            .leadingOf(view, 16),
            .height(44)
        )
        scrollView.set(
            .top(backButton.bottom),
            .leadingOf(view),
            .trailingOf(view),
            .bottomOf(view)
        )
        contentView.set(
            .topOf(scrollView),
            .leadingOf(scrollView),
            .trailingOf(scrollView),
            .bottomOf(scrollView),
            .widthOf(scrollView)
        )
        imageView.set(
            .topOf(contentView, 16),
            .leadingOf(contentView),
            .trailingOf(contentView),
            .heightMultiple(view.height, 0.66)
        )
        productNameLabel.set(
            .top(imageView.bottom, 16),
            .leadingOf(contentView, 16),
            .trailingOf(contentView, 16)
        )
        priceLabel.set(
            .top(productNameLabel.bottom, 8),
            .leadingOf(contentView, 16)
        )
        descriptionLabel.set(
            .top(priceLabel.bottom, 16),
            .leadingOf(contentView, 16),
            .trailingOf(contentView, 16)
        )
        addToBagButton.set(
            .top(descriptionLabel.bottom, 24),
            .centerXOf(contentView),
            .bottomOf(contentView, 24),
            .width(200),
            .height(44))
    }
    
    func setImageView(imageUrl: String) {
        imageView.loadImage(from: imageUrl)
        imageView.isHidden = false
    }
    
    func setProductNameLabel(text: String) {
        productNameLabel.text = text
        productNameLabel.isHidden = false
    }
    
    func setPriceLabel(text: String) {
        priceLabel.text = text
        priceLabel.isHidden = false
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
        descriptionLabel.isHidden = false
    }
}
