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
    
    private lazy var containerView: UIView = {
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
        button.backgroundColor = .systemGray2
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(didTapAddToBag), for: .touchUpInside)
        return button
    }()
    
    private lazy var bagBarButton: UIBarButtonItem = {
        let bagBarButton = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(didTapBasketButton)
        )
        return bagBarButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Task {
            await presenter.viewDidLoad()
        }
    }
    
    @objc
    private func didTapAddToBag() {
        presenter.didTapAddToCartButton()
    }
    
    @objc
    private func didTapBack() {
        presenter.didTapBackButton()
    }
    
    @objc
    private func didTapBasketButton() {
        presenter.didTapBasketButton()
    }
}

// MARK: - ProductDetailViewInterface
extension ProductDetailViewController: ProductDetailViewInterface {
    func prepareUI() {
        navigationItem.rightBarButtonItem = bagBarButton
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        view.addSubview(addToBagButton)
        
        containerView.addSubview(imageView)
        containerView.addSubview(productNameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(descriptionLabel)
        
        
        scrollView.set(
            .top(view.safeAreaLayoutGuide.topAnchor),
            .leadingOf(view),
            .trailingOf(view),
            .bottomOf(view)
        )
        containerView.set(
            .topOf(scrollView),
            .leadingOf(scrollView),
            .trailingOf(scrollView),
            .bottomOf(scrollView),
            .widthOf(scrollView)
        )
        imageView.set(
            .topOf(containerView, 16),
            .leadingOf(containerView),
            .trailingOf(containerView),
            .heightMultiple(view.height, 0.66)
        )
        productNameLabel.set(
            .top(imageView.bottom, 16),
            .leadingOf(containerView, 16),
            .trailingOf(containerView, 16)
        )
        priceLabel.set(
            .top(productNameLabel.bottom, 8),
            .leadingOf(containerView, 16)
        )
        descriptionLabel.set(
            .top(priceLabel.bottom, 16),
            .leadingOf(containerView, 16),
            .trailingOf(containerView, 16),
            .bottomOf(containerView, 16)
        )
        addToBagButton.set(
            .bottomOf(view, 32),
            .trailingOf(view, 16),
            .width(40),
            .height(40))
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
