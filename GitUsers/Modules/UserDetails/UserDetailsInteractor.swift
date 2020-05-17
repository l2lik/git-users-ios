//
//  UserDetailsInteractor.swift
//  GitUsers
//
//  Created by Aleksei Shmyrov on 14.05.2020.
//  Copyright © 2020 Aleksei Shmyrov. All rights reserved.
//

import Foundation

protocol UserDetailsBusinessLogic: class {
	func fetchUser()
}

class UserDetailsInteractor {
	var presenter: UserDetailsPresentationLogic?
	
	private let username: String
	private let networkDispatcher = DefaultNetworkDispatcher(environment: GithubNetworkEnvironment())
	private var user: UserResponse?
	
	init(username: String) {
		self.username = username
	}
}

// MARK: - UserDetailsBusinessLogic
extension UserDetailsInteractor: UserDetailsBusinessLogic {
	func fetchUser() {
		SingleUserTask(username: username).execute(in: networkDispatcher) { [weak self] (result) in
			guard let self = self else { return }
			
			switch result {
			case .success(let user):
				print(user)
				self.user = user
				self.presenter?.presentUser(user: user)
			case .failure(let error):
				self.presenter?.presentError(error: error)
			}
		}
	}
}
