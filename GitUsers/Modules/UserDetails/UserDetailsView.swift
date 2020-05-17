//
//  UserDetailsView.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import UIKit

protocol UserDetailsDisplayLogic: class {
	func displayUsers(viewModel: UserDetails.ViewModel)
	func displayError(error: Error)
}

class UserDetailsView: UIViewController {
	
	var interactor: UserDetailsBusinessLogic?

	@IBOutlet weak var avatarImageView: UIImageView! {
		didSet {
			avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
			avatarImageView.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var usernameLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        title = "GitHub User Details"
		
		interactor?.fetchUser()
    }
}

// MARK: - UserDetailsDisplayLogic
extension UserDetailsView: UserDetailsDisplayLogic {
	func displayUsers(viewModel: UserDetails.ViewModel) {
		if let avatarURL = viewModel.avatarURL {
			avatarImageView.setImage(with: avatarURL)
		}
		usernameLabel.text = viewModel.username ?? ""
	}
	
	func displayError(error: Error) {
		showError(error)
	}
}

// MARK: - ErrorPresentable
extension UserDetailsView: ErrorPresentable { }
