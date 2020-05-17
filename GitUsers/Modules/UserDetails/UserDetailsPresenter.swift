//
//  UserDetailsPresenter.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol UserDetailsPresentationLogic: class {
	func presentUser(user: UserResponse)
	func presentError(error: Error)
}

class UserDetailsPresenter: NSObject {
	weak var view: UserDetailsDisplayLogic?
}

// MARK: - UserDetailsPresentationLogic
extension UserDetailsPresenter: UserDetailsPresentationLogic {
	func presentUser(user: UserResponse) {
		view?.displayUsers(viewModel: UserDetails.ViewModel(avatarURL: user.avatarUrl, username: user.login))
	}
	
	func presentError(error: Error) {
		view?.displayError(error: error)
	}
}
