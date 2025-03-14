//
//  ProductDetailViewController.swift
//  ProductDetail
//
//  Created by Yasin Akbas on 10.03.2025.
//

import UIKit
import UILab
import CommonViewKit

enum AddToBasketButtonState {
    case addable, unaddable
}

protocol ProductDetailViewInterface: LoadingShowable, AlertShowable {
    func prepareUI()
    func prepareNavigationBar()
    func setProductNameLabel(text: String)
    func setPriceLabel(text: String)
    func setDescriptionLabel(text: String)
    func updateAddToBasketButton(for state: AddToBasketButtonState)
    
    func prepareProductDetailSizeSelectionView(arguments: ProductDetailSizeSelectionArguments) -> ProductDetailSizeSelectionModule
    func prepareProductDetailImageSliderView(arguments: ProductDetailImageSliderArguments) -> ProductDetailImageSliderModule
}

private extension ProductDetailViewController {
    enum Constants {
        enum AddToBasketButton {
            enum Addable {
                static let buttonTitle: String = "+"
                static let backgroundColor: UIColor = Colors.primary
            }
            enum Unaddable {
                static let buttonTitle: String = "-"
                static let backgroundColor: UIColor = Colors.alertRed
            }
            
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
        
        enum BasketButton {
            static let iconName: String = "cart"
        }
    }
}

final class ProductDetailViewController: UIViewController {
    var presenter: ProductDetailPresenterInterface!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var imageSliderContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var sizeSelectionContainerView: UIView = {
        let view = UIView()
        return view
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
    
    private lazy var addToBasketButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(didTapAddToBag), for: .touchUpInside)
        return button
    }()
    
    private lazy var bagBarButton: UIBarButtonItem = {
        let bagBarButton = UIBarButtonItem(
            image: UIImage(systemName: Constants.BasketButton.iconName),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        view.addSubview(addToBasketButton)
        
        containerView.addArrangedSubview(imageSliderContainerView)
        containerView.addArrangedSubview(productNameLabel)
        containerView.addArrangedSubview(sizeSelectionContainerView)
        containerView.addArrangedSubview(priceLabel)
        containerView.addArrangedSubview(descriptionLabel)
        
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
        
        addToBasketButton.set(
            .bottomOf(view, 32),
            .trailingOf(view, 16),
            .width(Constants.AddToBasketButton.width),
            .height(Constants.AddToBasketButton.height)
        )
    }
    
    func prepareNavigationBar() {
        navigationItem.rightBarButtonItem = bagBarButton
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
    
    func prepareProductDetailSizeSelectionView(arguments: ProductDetailSizeSelectionArguments) -> ProductDetailSizeSelectionModule {
        let (productDetailSizeSelectionView, productDetailSizeSelectionModule) = ProductDetailSizeSelectionRouter.createModule(delegate: presenter.productDetailSizeSelectionDelegate, arguments: arguments)
        embed(productDetailSizeSelectionView, in: sizeSelectionContainerView)
        return productDetailSizeSelectionModule
    }
    
    func prepareProductDetailImageSliderView(arguments: ProductDetailImageSliderArguments) -> ProductDetailImageSliderModule {
        let (productDetailImageSliderView, productDetailImageSliderModule) = ProductDetailImageSliderRouter.createModule(arguments: arguments)
        embed(productDetailImageSliderView, in: imageSliderContainerView)
        return productDetailImageSliderModule
    }
    
    func updateAddToBasketButton(for state: AddToBasketButtonState) {
        switch state {
        case .addable:
            addToBasketButton.setTitle(Constants.AddToBasketButton.Addable.buttonTitle, for: .normal)
            addToBasketButton.backgroundColor = Constants.AddToBasketButton.Addable.backgroundColor
        case .unaddable:
            addToBasketButton.setTitle(Constants.AddToBasketButton.Unaddable.buttonTitle, for: .normal)
            addToBasketButton.backgroundColor = Constants.AddToBasketButton.Unaddable.backgroundColor
        }
    }
}
