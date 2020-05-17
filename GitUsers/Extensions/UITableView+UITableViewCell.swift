//
//  UITableView+UITableViewCell.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

extension UITableView {
	func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(
            UINib(nibName: String(describing: cellClass), bundle: nil),
            forCellReuseIdentifier: String(describing: cellClass))
    }
    
	func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(
            withIdentifier: String(describing: cellClass),
            for: indexPath) as! T
        return cell
    }
}
