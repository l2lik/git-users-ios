//
//  UsersPresenter.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol UsersPresentationLogic: class {
	func presentUsers(users: [UserResponse])
	func presentFoundUsers(users: [UserResponse])
	func presentError(error: Error)
}

class UsersPresenter {
	weak var view: UsersDisplayLogic?
}

// MARK: - UsersPresentationLogic
extension UsersPresenter: UsersPresentationLogic {
	func presentUsers(users: [UserResponse]) {
		let userCellViewModels = users.map { Users.ViewModel.CellViewModel(avatarURL: $0.avatarUrl, username: $0.login) }
		view?.displayUsers(viewModel: Users.ViewModel(users: userCellViewModels))
	}
	
	func presentFoundUsers(users: [UserResponse]) {
		let userCellViewModels = users.map { Users.ViewModel.CellViewModel(avatarURL: $0.avatarUrl, username: $0.login) }
		view?.displayFoundUsers(viewModel: Users.ViewModel(users: userCellViewModels))
	}
	
	func presentError(error: Error) {
		view?.displayError(error: error)
	}
}
