//
//  ProductDetailSizeSelectionViewController.swift
//  ProductDetailModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import UILab
import CommonViewKit

protocol ProductDetailSizeSelectionViewInterface: AnyObject {
    func prepareUI()
    func reloadData()
    func selectItem(at indexPath: IndexPath)
}

private extension ProductDetailSizeSelectionViewController {
    enum Constants {
        enum CollectionView {
            static let minimumInteritemSpacing: CGFloat = 8
            static let minimumLineSpacing: CGFloat = 8
            static let itemHeight: CGFloat = 32
            static let itemHorizontalSpacing: CGFloat = 20
        }
    }
}

final class ProductDetailSizeSelectionViewController: UIViewController {
    var presenter: ProductDetailSizeSelectionPresenterInterface!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = Constants.CollectionView.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.CollectionView.minimumLineSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: ProductDetailSizeCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - ProductDetailSizeSelectionViewInterface
extension ProductDetailSizeSelectionViewController: ProductDetailSizeSelectionViewInterface {
    func prepareUI() {
        view.addSubview(collectionView)
        collectionView.set(
            .topOf(view),
            .leadingOf(view),
            .trailingOf(view),
            .bottomOf(view),
            .height(Constants.CollectionView.itemHeight)
        )
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func selectItem(at indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        presenter.didSelectSize(at: indexPath)
    }
}

// MARK: UICollectionViewDataSource
extension ProductDetailSizeSelectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductDetailSizeCell.self, for: indexPath)
        let size = presenter.size(at: indexPath)
        cell.configure(with: size)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailSizeSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSize(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let labelWidth = presenter.size(at: indexPath).size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width
        return CGSize(width: labelWidth + Constants.CollectionView.itemHorizontalSpacing, height: Constants.CollectionView.itemHeight)
    }
}

extension UICollectionView {
    override open var intrinsicContentSize: CGSize {
        return contentSize
    }
}
