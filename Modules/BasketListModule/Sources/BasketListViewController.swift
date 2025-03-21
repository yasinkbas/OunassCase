//
//  BasketListViewController.swift
//  BasketListModule
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit
import UILab
import CommonViewKit

protocol BasketListViewInterface: EmptyViewShowable {
    func prepareUI()
    func reloadTableView()
}

private extension BasketListViewController {
    enum Constants {
        static let title: String = "Basket"
        
        enum EmptyView {
            static let message: String = "There is no product in your basket"
            static let titleColor: UIColor = .black
            static let fontSize: CGFloat = 18
        }
    }
}

final class BasketListViewController: UIViewController {
    var presenter: BasketListPresenterInterface!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(cellType: UITableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - BasketListViewInterface
extension BasketListViewController: BasketListViewInterface {
    var emptyViewArguments: CommonViewKit.EmptyViewPresenterArguments {
        .init(
            message: Constants.EmptyView.message,
            titleColor: Constants.EmptyView.titleColor,
            titleFontSize: Constants.EmptyView.fontSize
        )
    }
    
    func prepareUI() {
        view.backgroundColor = .white
        title = Constants.title
        view.addSubview(tableView)
        tableView.set(
            .top(view.safeAreaLayoutGuide.topAnchor),
            .leadingOf(view),
            .trailingOf(view),
            .bottomOf(view)
        )
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension BasketListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = presenter.productName(at: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
