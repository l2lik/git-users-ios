//
//  Presentable.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

protocol Presentable: class {
	var toPresent: UIViewController { get }
}

extension UIViewController: Presentable {
	var toPresent: UIViewController {
		return self
	}
}
