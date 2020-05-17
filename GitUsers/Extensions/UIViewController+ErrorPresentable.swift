//
//  UIViewController+ErrorPresentable.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

protocol ErrorPresentable where Self: UIViewController {
	func showError(_ error: Error)
}

extension ErrorPresentable {
	func showError(_ error: Error) {
		print(error.localizedDescription)
		let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true)
	}
}
