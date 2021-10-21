//
//  RegistableCell.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit

protocol RegistableCell: AnyObject {}

extension UITableViewCell: RegistableCell {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: Self.self.description())
    }

    static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: Self.self.description(), for: indexPath) as? Self ?? Self()
    }
}

extension UICollectionViewCell: RegistableCell {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: Self.self.description())
    }

    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Self.self.description(), for: indexPath) as? Self ?? Self()
    }
}

extension UITableViewHeaderFooterView: RegistableCell {
    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forHeaderFooterViewReuseIdentifier: Self.self.description())
    }

    static func dequeue(from tableView: UITableView) -> Self {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.self.description()) as? Self ?? Self()
    }
}
