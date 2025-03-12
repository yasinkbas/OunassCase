//
//  UITableView+Extensions.swift
//  OunassCase
//
//  Created by Yasin Akbas on 12.03.2025.
//

import UIKit

public extension UITableView {
    func register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
