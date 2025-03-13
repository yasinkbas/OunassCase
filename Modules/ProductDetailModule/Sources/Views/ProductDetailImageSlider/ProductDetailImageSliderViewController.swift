//
//  ProductDetailImageSliderViewController.swift
//  ProductDetailModule
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit

protocol ProductDetailImageSliderViewInterface: AnyObject {
    func prepareUI()
    func reloadData()
}

private extension ProductDetailImageSliderViewController {
    enum Constants {
        static let collectionViewItemHeight: CGFloat = 600
    }
}

final class ProductDetailImageSliderViewController: UIViewController {
    var presenter: ProductDetailImageSliderPresenterInterface!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: Constants.collectionViewItemHeight)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ProductDetailImageCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - ProductDetailImageSliderViewInterface
extension ProductDetailImageSliderViewController: ProductDetailImageSliderViewInterface { 
    func prepareUI() {
        view.addSubview(collectionView)
        collectionView.set(
            .leadingOf(view),
            .topOf(view),
            .trailingOf(view),
            .bottomOf(view),
            .height(Constants.collectionViewItemHeight)
        )
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ProductDetailImageSliderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfImages()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductDetailImageCell.self, for: indexPath)
        let imageUrl = presenter.imageUrl(at: indexPath)
        cell.configure(with: imageUrl)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailImageSliderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
