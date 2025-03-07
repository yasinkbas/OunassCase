//
//  ProductListViewController.swift
//  ProductList
//
//  Created by Yasin Akbas on 5.03.2025.
//

import UIKit
import UILab
import CommonKit

protocol ProductListViewInterface: AnyObject {
    func prepareUI()
    func reloadCollectionView()
}

private extension ProductListViewController {
    enum Constants {
        enum CollectionView {
            static let minimumInteritemSpacing: CGFloat = 8
            static let minimumLineSpacing: CGFloat = 8
            static let sectionInset: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)

        }
        
        static let pageName: String = "Product List"
    }
}

final class ProductListViewController: UIViewController {
    var presenter: ProductListPresenterInterface!
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumInteritemSpacing = Constants.CollectionView.minimumInteritemSpacing
        layout.minimumLineSpacing = Constants.CollectionView.minimumLineSpacing
        layout.sectionInset = Constants.CollectionView.sectionInset
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellType: ProductCell.self, bundle: .main)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = Constants.pageName
        
        Task {
            await presenter.viewDidLoad()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - ProductListViewInterface
extension ProductListViewController: ProductListViewInterface {
    func prepareUI() {
        view.addSubview(collectionView)
        collectionView.set(.top(view.safeAreaLayoutGuide.topAnchor), .bottomOf(view), .leadingOf(view), .trailingOf(view))
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ProductCell.self, for: indexPath)
        let productCellArguments = presenter.productCellArguments(for: indexPath)
        cell.configure(with: productCellArguments)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = presenter.collectionViewSizeForItemAt(viewWidth: view.bounds.width)
        return CGSize(width: size.width, height: size.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.collectionViewDidSelectItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        Task {
            await presenter.collectionViewWillDisplay(indexPath: indexPath)
        }
    }
}
